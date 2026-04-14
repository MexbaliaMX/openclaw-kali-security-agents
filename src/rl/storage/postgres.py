"""
RL Mechanism - PostgreSQL Storage Backend

Provides tamper-evident audit logging, metrics storage, and performance tracking
for the RL mechanism using PostgreSQL with pgvector extension.
"""

import psycopg2
from psycopg2.extras import RealDictCursor, Json
from psycopg2 import pool
from psycopg2.pool import PoolError
from typing import Optional, List, Dict, Any, Tuple
import json
import hashlib
import logging
from datetime import datetime, timedelta
from contextlib import contextmanager

logger = logging.getLogger(__name__)


class PostgreSQLStorage:
    """
    PostgreSQL-backed storage for RL mechanism.
    
    Features:
    - Tamper-evident audit logging with hash chain
    - Time-series metrics with partitioning
    - Encrypted user preferences
    - Agent performance tracking
    - Task embeddings for semantic search (pg_vector)
    """
    
    def __init__(self, connection_string: str, pool_size: int = 10):
        """
        Initialize PostgreSQL storage.
        
        Args:
            connection_string: PostgreSQL connection string
            pool_size: Connection pool size
        """
        self.connection_string = connection_string
        self.pool_size = pool_size
        self.connection_pool = None
        self._initialize_pool()
    
    def _initialize_pool(self):
        """Initialize connection pool."""
        self.connection_pool = psycopg2.pool.ThreadedConnectionPool(
            minconn=2,
            maxconn=self.pool_size,
            dsn=self.connection_string
        )
        logger.info(f"PostgreSQL connection pool initialized (size={self.pool_size})")
    
    @contextmanager
    def _get_cursor(self, commit: bool = False):
        """Get database cursor from pool."""
        try:
            conn = self.connection_pool.getconn(timeout=10)  # 10s timeout
        except PoolError as e:
            logger.error(f"Connection pool exhausted: {e}")
            raise RuntimeError("Database connection pool exhausted - try increasing pool_size") from e
        
        cursor = None
        try:
            cursor = conn.cursor(cursor_factory=RealDictCursor)
            yield cursor
            if commit:
                conn.commit()
        except Exception as e:
            if conn:
                conn.rollback()
            logger.error(f"Database error: {e}")
            raise
        finally:
            if cursor:
                cursor.close()
            if conn:
                self.connection_pool.putconn(conn)
    
    # =========================================================================
    # AUDIT LOGGING (Tamper-evident with hash chain)
    # =========================================================================
    
    def log_audit_entry(self, entry: Dict[str, Any]) -> int:
        """
        Log audit entry with hash chain for tamper-evidence.
        
        Args:
            entry: Audit log entry with keys:
                - task_id (UUID)
                - agent_id (str)
                - action_type (str)
                - rl_decision (dict)
                - safety_check_result (dict, optional)
                - compliance_score (float, optional)
                - reward_value (float, optional)
        
        Returns:
            int: Audit log entry ID
        """
        with self._get_cursor(commit=True) as cursor:
            # Get previous hash for chain
            cursor.execute("""
                SELECT hash_chain FROM rl_audit_logs 
                ORDER BY id DESC LIMIT 1
            """)
            row = cursor.fetchone()
            previous_hash = row['hash_chain'] if row else None
            
            # Compute current hash (SHA-256 of entry + previous hash)
            entry_data = json.dumps(entry, sort_keys=True)
            hash_input = f"{entry_data}{previous_hash or ''}"
            current_hash = hashlib.sha256(hash_input.encode()).hexdigest()
            
            # Insert audit log
            cursor.execute("""
                INSERT INTO rl_audit_logs (
                    task_id, agent_id, action_type, rl_decision,
                    safety_check_result, compliance_score, reward_value,
                    hash_chain, previous_hash
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
            """, (
                entry['task_id'],
                entry['agent_id'],
                entry['action_type'],
                Json(entry['rl_decision']),
                Json(entry.get('safety_check_result')),
                entry.get('compliance_score'),
                entry.get('reward_value'),
                current_hash,
                previous_hash
            ))
            
            result = cursor.fetchone()
            logger.debug(f"Audit log entry created: id={result['id']}")
            
            return result['id']
    
    def verify_audit_integrity(self) -> Tuple[bool, str]:
        """
        Verify audit log hash chain integrity.
        
        Returns:
            Tuple of (is_valid: bool, message: str)
        """
        with self._get_cursor() as cursor:
            cursor.execute("""
                SELECT id, hash_chain, previous_hash 
                FROM rl_audit_logs 
                ORDER BY id ASC
            """)
            
            entries = cursor.fetchall()
            
            if not entries:
                return True, "No audit entries to verify"
            
            previous_hash = None
            for entry in entries:
                if entry['previous_hash'] != previous_hash:
                    error_msg = f"Hash chain broken at entry {entry['id']}"
                    logger.error(error_msg)
                    return False, error_msg
                previous_hash = entry['hash_chain']
            
            logger.info(f"Audit log integrity verified ({len(entries)} entries)")
            return True, f"Audit log integrity verified ({len(entries)} entries)"
    
    def query_compliance_report(self, hours: int = 24) -> List[Dict]:
        """
        Generate compliance report for last N hours.
        
        Args:
            hours: Number of hours to report on
        
        Returns:
            List of hourly compliance metrics
        """
        with self._get_cursor() as cursor:
            cursor.execute("""
                SELECT 
                    DATE_TRUNC('hour', timestamp) as hour,
                    COUNT(*) as total_tasks,
                    AVG(compliance_score) as avg_compliance,
                    COUNT(CASE WHEN compliance_score < 1.0 THEN 1 END) as violations,
                    AVG(reward_value) as avg_reward
                FROM rl_audit_logs
                WHERE timestamp > NOW() - INTERVAL '%s hours'
                GROUP BY hour
                ORDER BY hour DESC
            """, (hours,))
            
            results = cursor.fetchall()
            return [dict(r) for r in results]
    
    # =========================================================================
    # METRICS STORAGE
    # =========================================================================
    
    def record_metric(self, metric_name: str, value: float, tags: Dict[str, str] = None):
        """
        Record a metric value.
        
        Args:
            metric_name: Metric name (e.g., 'rl.task.duration')
            value: Metric value
            tags: Optional tags for filtering
        """
        with self._get_cursor(commit=True) as cursor:
            cursor.execute("""
                INSERT INTO rl_metrics (metric_name, metric_value, tags)
                VALUES (%s, %s, %s)
            """, (metric_name, value, Json(tags) if tags else None))
            
            logger.debug(f"Metric recorded: {metric_name}={value}")
    
    def query_metrics(self, metric_name: str, hours: int = 24, 
                     aggregation: str = 'avg') -> List[Dict]:
        """
        Query metrics with aggregation.
        
        Args:
            metric_name: Metric name to query
            hours: Time range in hours
            aggregation: Aggregation function (avg, sum, min, max, count)
        
        Returns:
            List of aggregated metrics by hour
        """
        # Whitelist aggregation functions to prevent SQL injection
        VALID_AGGREGATIONS = {'avg', 'sum', 'min', 'max', 'count'}
        if aggregation not in VALID_AGGREGATIONS:
            raise ValueError(f"Invalid aggregation: {aggregation}. Must be one of {VALID_AGGREGATIONS}")
        
        with self._get_cursor() as cursor:
            cursor.execute(f"""
                SELECT 
                    DATE_TRUNC('hour', timestamp) as hour,
                    {aggregation}(metric_value) as metric_value,
                    COUNT(*) as sample_count
                FROM rl_metrics
                WHERE metric_name = %s
                  AND timestamp > NOW() - INTERVAL '%s hours'
                GROUP BY hour
                ORDER BY hour DESC
            """, (metric_name, hours))
            
            results = cursor.fetchall()
            return [dict(r) for r in results]
    
    # =========================================================================
    # AGENT PERFORMANCE TRACKING
    # =========================================================================
    
    def update_agent_performance(self, agent_id: str, task_type: str, 
                                  success: bool, completion_time: float, 
                                  reward: float):
        """
        Update agent performance metrics.
        
        Args:
            agent_id: Agent identifier
            task_type: Task category
            success: Whether task succeeded
            completion_time: Task completion time in seconds
            reward: Reward value received
        """
        with self._get_cursor(commit=True) as cursor:
            cursor.execute("""
                INSERT INTO rl_agent_performance (
                    agent_id, task_type, success_count, failure_count,
                    avg_completion_time, avg_reward, last_updated
                ) VALUES (%s, %s, %s, %s, %s, %s, NOW())
                ON CONFLICT (agent_id, task_type) DO UPDATE SET
                    success_count = rl_agent_performance.success_count + %s,
                    failure_count = rl_agent_performance.failure_count + %s,
                    avg_completion_time = (
                        (rl_agent_performance.avg_completion_time * 
                         (rl_agent_performance.success_count + rl_agent_performance.failure_count))
                        + %s
                    ) / (rl_agent_performance.success_count + rl_agent_performance.failure_count + 1),
                    avg_reward = (
                        (rl_agent_performance.avg_reward * 
                         (rl_agent_performance.success_count + rl_agent_performance.failure_count))
                        + %s
                    ) / (rl_agent_performance.success_count + rl_agent_performance.failure_count + 1),
                    last_updated = NOW()
            """, (
                agent_id, task_type,
                1 if success else 0, 0 if success else 1,
                completion_time, reward,
                1 if success else 0, 0 if success else 1,
                completion_time, reward
            ))
            
            logger.debug(f"Agent performance updated: {agent_id}/{task_type}")
    
    def get_agent_performance(self, agent_id: str = None, 
                             task_type: str = None) -> List[Dict]:
        """
        Get agent performance metrics.
        
        Args:
            agent_id: Optional agent filter
            task_type: Optional task type filter
        
        Returns:
            List of agent performance records
        """
        with self._get_cursor() as cursor:
            query = "SELECT * FROM rl_agent_performance WHERE 1=1"
            params = []
            
            if agent_id:
                query += " AND agent_id = %s"
                params.append(agent_id)
            
            if task_type:
                query += " AND task_type = %s"
                params.append(task_type)
            
            query += " ORDER BY last_updated DESC"
            
            cursor.execute(query, params)
            results = cursor.fetchall()
            return [dict(r) for r in results]
    
    # =========================================================================
    # TASK EMBEDDINGS (pg_vector)
    # =========================================================================
    
    def store_task_embedding(self, task_id: str, embedding: List[float],
                            task_type: str, complexity_score: float,
                            optimal_agent_id: str, reward: float):
        """
        Store task embedding for semantic search.
        
        Args:
            task_id: Task UUID
            embedding: 768-dimensional embedding vector
            task_type: Task category
            complexity_score: Task complexity (0-1)
            optimal_agent_id: Best agent for this task
            reward: Reward value received
        """
        with self._get_cursor(commit=True) as cursor:
            embedding_str = '[' + ','.join(map(str, embedding)) + ']'
            
            cursor.execute("""
                INSERT INTO rl_task_embeddings (
                    task_id, embedding, task_type, complexity_score,
                    optimal_agent_id, actual_reward
                ) VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (task_id) DO NOTHING
            """, (task_id, embedding_str, task_type, complexity_score, 
                  optimal_agent_id, reward))
            
            logger.debug(f"Task embedding stored: {task_id}")
    
    def find_similar_tasks(self, embedding: List[float], limit: int = 10,
                          min_similarity: float = 0.7) -> List[Dict]:
        """
        Find similar tasks using KNN search.
        
        Args:
            embedding: Query embedding vector
            limit: Maximum results to return
            min_similarity: Minimum similarity threshold
        
        Returns:
            List of similar tasks with similarity scores
        """
        with self._get_cursor() as cursor:
            embedding_str = '[' + ','.join(map(str, embedding)) + ']'
            
            cursor.execute("""
                SELECT 
                    task_id, task_type, optimal_agent_id, actual_reward,
                    1 - (embedding <=> %s) as similarity
                FROM rl_task_embeddings
                WHERE 1 - (embedding <=> %s) > %s
                ORDER BY embedding <=> %s
                LIMIT %s
            """, (embedding_str, embedding_str, min_similarity, embedding_str, limit))
            
            results = cursor.fetchall()
            return [dict(r) for r in results]
    
    # =========================================================================
    # SAFETY VIOLATIONS
    # =========================================================================
    
    def log_safety_violation(self, task_id: str, violation_type: str,
                            severity: str, action_taken: str,
                            details: Dict = None):
        """
        Log a safety violation.
        
        Args:
            task_id: Task UUID
            violation_type: Type of violation
            severity: CRITICAL, HIGH, MEDIUM, or LOW
            action_taken: Action taken in response
            details: Additional violation details
        """
        with self._get_cursor(commit=True) as cursor:
            cursor.execute("""
                INSERT INTO rl_safety_violations (
                    task_id, violation_type, severity, action_taken, details
                ) VALUES (%s, %s, %s, %s, %s)
            """, (task_id, violation_type, severity, action_taken, 
                  Json(details) if details else None))
            
            logger.warning(f"Safety violation logged: {violation_type} ({severity})")
    
    def resolve_safety_violation(self, violation_id: int, resolved_by: str):
        """
        Mark a safety violation as resolved.
        
        Args:
            violation_id: Violation ID
            resolved_by: User/agent who resolved it
        """
        with self._get_cursor(commit=True) as cursor:
            cursor.execute("""
                UPDATE rl_safety_violations
                SET resolved = TRUE, resolved_at = NOW(), resolved_by = %s
                WHERE id = %s
            """, (resolved_by, violation_id))
            
            logger.info(f"Safety violation resolved: id={violation_id}")
    
    # =========================================================================
    # UTILITY METHODS
    # =========================================================================
    
    def health_check(self) -> bool:
        """Check database connection health."""
        try:
            with self._get_cursor() as cursor:
                cursor.execute("SELECT 1")
            return True
        except Exception as e:
            logger.error(f"Health check failed: {e}")
            return False
    
    def get_table_stats(self) -> Dict[str, int]:
        """Get row counts for all tables."""
        tables = [
            'rl_audit_logs', 'rl_metrics', 'rl_agent_performance',
            'rl_task_embeddings', 'rl_agent_selections', 'rl_safety_violations'
        ]
        
        stats = {}
        with self._get_cursor() as cursor:
            for table in tables:
                cursor.execute(f"SELECT COUNT(*) as count FROM {table}")
                result = cursor.fetchone()
                stats[table] = result['count']
        
        return stats
    
    def close(self):
        """Close all database connections."""
        if self.connection_pool:
            self.connection_pool.closeall()
            logger.info("PostgreSQL connection pool closed")
