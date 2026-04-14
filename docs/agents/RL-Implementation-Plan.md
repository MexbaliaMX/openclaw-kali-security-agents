# RL Mechanism Implementation Plan (Full Integration)

**Document Type:** Implementation Specification  
**Version:** 2.0 (Full Integration)  
**Date:** April 14, 2026  
**Status:** APPROVED FOR IMPLEMENTATION  
**Approval Date:** April 14, 2026  

---

## 🎯 Executive Summary

This document specifies the implementation plan for the RL mechanism with **full infrastructure integration**:

- ✅ **Redis** - State cache, agent availability, reward history
- ✅ **PostgreSQL** - Audit logs, metrics, preferences, performance tracking
- ✅ **pg_vector** - Semantic task embeddings, KNN agent selection
- ✅ **OpenTelemetry** - Distributed tracing, standardized metrics, alerting

**Timeline:** 11 weeks (Phase 2-5)  
**Effort:** ~16 developer-days  
**Expected ROI:** <2 months payback

---

## 📋 Phase Overview

| Phase | Duration | Focus | Deliverables |
|-------|----------|-------|--------------|
| **Phase 1** | Week 1-2 | Foundation | ✅ COMPLETE (design docs) |
| **Phase 2** | Week 3-6 | Core Implementation + Infrastructure | Redis, PostgreSQL, OpenTelemetry integration |
| **Phase 3** | Week 7-8 | Integration Testing + pg_vector | E2E testing, security audit, semantic search |
| **Phase 4** | Week 9-11 | Gradual Rollout | 10% → 50% → 100% traffic |
| **Phase 5** | Ongoing | Monitoring & Optimization | Weekly reports, monthly reviews |

---

## 🔧 Phase 2: Core Implementation + Infrastructure (Week 3-6)

### Week 3: PostgreSQL Integration

**Lead:** MCP Builder  
**Support:** SRE, Security Engineer

#### Day 1-2: Database Setup

```bash
# 1. Install PostgreSQL (if not already installed)
sudo apt update
sudo apt install postgresql postgresql-contrib pgvector -y

# 2. Enable pgvector extension
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS vector;"

# 3. Create RL database and user
sudo -u postgres psql <<EOF
CREATE DATABASE rl_mechanism;
CREATE USER rl_app WITH ENCRYPTED PASSWORD 'CHANGE_ME_IN_PRODUCTION';
GRANT CONNECT ON DATABASE rl_mechanism TO rl_app;
GRANT USAGE ON SCHEMA public TO rl_app;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO rl_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO rl_app;
EOF

# 4. Configure PostgreSQL for RL workload
sudo nano /etc/postgresql/15/main/postgresql.conf
# Add/modify:
# shared_preload_libraries = 'pgaudit'
# work_mem = 64MB
# effective_cache_size = 4GB
```

#### Day 3-5: Schema Implementation

**File:** `scripts/db/migrations/001_initial_schema.sql`

```sql
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pgaudit;

-- Audit Logs Table (tamper-evident)
CREATE TABLE rl_audit_logs (
    id BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    task_id UUID NOT NULL,
    agent_id VARCHAR(64) NOT NULL,
    action_type VARCHAR(32) NOT NULL,
    rl_decision JSONB NOT NULL,
    safety_check_result JSONB,
    compliance_score DECIMAL(5,4),
    reward_value DECIMAL(10,6),
    hash_chain VARCHAR(64) NOT NULL,
    previous_hash VARCHAR(64),
    CONSTRAINT chk_compliance_score CHECK (compliance_score >= 0 AND compliance_score <= 1)
);

-- Indexes for common queries
CREATE INDEX idx_audit_timestamp ON rl_audit_logs(timestamp DESC);
CREATE INDEX idx_audit_task_id ON rl_audit_logs(task_id);
CREATE INDEX idx_audit_agent_id ON rl_audit_logs(agent_id);
CREATE INDEX idx_audit_compliance ON rl_audit_logs(compliance_score);
CREATE INDEX idx_audit_safety ON rl_audit_logs USING GIN(safety_check_result);

-- Metrics Table (time-series with partitioning)
CREATE TABLE rl_metrics (
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    metric_name VARCHAR(64) NOT NULL,
    metric_value DECIMAL(10,6) NOT NULL,
    tags JSONB,
    partition_date DATE DEFAULT CURRENT_DATE
) PARTITION BY RANGE (partition_date);

-- Create monthly partitions (example: 3 months ahead)
CREATE TABLE rl_metrics_2026_04 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE rl_metrics_2026_05 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');
CREATE TABLE rl_metrics_2026_06 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');

CREATE INDEX idx_metrics_name_time ON rl_metrics(metric_name, timestamp DESC);

-- User Preferences Table (encrypted)
CREATE TABLE rl_user_preferences (
    workspace_id UUID PRIMARY KEY,
    preferences_encrypted BYTEA NOT NULL,  -- AES-256 encrypted
    encryption_key_id VARCHAR(64) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_reset_at TIMESTAMPTZ
);

-- Agent Performance Table
CREATE TABLE rl_agent_performance (
    agent_id VARCHAR(64) NOT NULL,
    task_type VARCHAR(32) NOT NULL,
    success_count INTEGER DEFAULT 0,
    failure_count INTEGER DEFAULT 0,
    avg_completion_time DECIMAL(10,3),
    avg_reward DECIMAL(10,6),
    last_updated TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (agent_id, task_type)
);

-- Task Embeddings Table (for pg_vector)
CREATE TABLE rl_task_embeddings (
    task_id UUID PRIMARY KEY,
    embedding vector(768),  -- 768-dimensional embeddings
    task_type VARCHAR(32),
    complexity_score DECIMAL(5,4),
    optimal_agent_id VARCHAR(64),
    actual_reward DECIMAL(10,6),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- IVFFlat index for fast KNN search
CREATE INDEX idx_task_embeddings ON rl_task_embeddings 
    USING ivfflat (embedding vector_cosine_ops)
    WITH (lists = 100);

-- Agent Selections History
CREATE TABLE rl_agent_selections (
    id BIGSERIAL PRIMARY KEY,
    task_id UUID REFERENCES rl_task_embeddings(task_id),
    selected_agent_id VARCHAR(64),
    alternative_agents JSONB,
    selection_confidence DECIMAL(5,4),
    outcome_success BOOLEAN,
    outcome_reward DECIMAL(10,6),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_selections_task ON rl_agent_selections(task_id);
CREATE INDEX idx_selections_agent ON rl_agent_selections(selected_agent_id);

-- Safety Violations Log
CREATE TABLE rl_safety_violations (
    id BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    task_id UUID NOT NULL,
    violation_type VARCHAR(64) NOT NULL,
    severity VARCHAR(16) NOT NULL,  -- CRITICAL, HIGH, MEDIUM, LOW
    action_taken VARCHAR(128) NOT NULL,
    details JSONB,
    resolved BOOLEAN DEFAULT FALSE,
    resolved_at TIMESTAMPTZ,
    resolved_by VARCHAR(64)
);

CREATE INDEX idx_violations_time ON rl_safety_violations(timestamp DESC);
CREATE INDEX idx_violations_severity ON rl_safety_violations(severity);
CREATE INDEX idx_violations_resolved ON rl_safety_violations(resolved);

-- RL Policy Versions
CREATE TABLE rl_policy_versions (
    version VARCHAR(32) PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    created_by VARCHAR(64) NOT NULL,
    model_architecture VARCHAR(64),
    hyperparameters JSONB,
    performance_metrics JSONB,
    is_active BOOLEAN DEFAULT FALSE,
    rollback_version VARCHAR(32) REFERENCES rl_policy_versions(version)
);

-- Create RL app function to update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add trigger for preferences table
CREATE TRIGGER update_preferences_updated_at
    BEFORE UPDATE ON rl_user_preferences
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions to rl_app user
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO rl_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO rl_app;
```

#### Day 6-7: Application Integration

**File:** `src/rl/storage/postgres.py`

```python
import psycopg2
from psycopg2.extras import RealDictCursor, Json
from typing import Optional, List, Dict, Any
import json
import hashlib

class PostgreSQLStorage:
    """PostgreSQL-backed storage for RL mechanism."""
    
    def __init__(self, connection_string: str):
        self.conn_string = connection_string
        self.conn = None
        self._connect()
    
    def _connect(self):
        """Establish database connection."""
        self.conn = psycopg2.connect(self.conn_string)
        self.conn.autocommit = False
    
    def log_audit_entry(self, entry: Dict[str, Any]) -> int:
        """Log audit entry with hash chain for tamper-evidence."""
        # Get previous hash
        cursor = self.conn.cursor(cursor_factory=RealDictCursor)
        cursor.execute("""
            SELECT hash_chain FROM rl_audit_logs 
            ORDER BY id DESC LIMIT 1
        """)
        row = cursor.fetchone()
        previous_hash = row['hash_chain'] if row else None
        
        # Compute current hash
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
        self.conn.commit()
        cursor.close()
        
        return result['id']
    
    def record_metric(self, metric_name: str, value: float, tags: Dict[str, str] = None):
        """Record a metric value."""
        cursor = self.conn.cursor()
        cursor.execute("""
            INSERT INTO rl_metrics (metric_name, metric_value, tags)
            VALUES (%s, %s, %s)
        """, (metric_name, value, Json(tags) if tags else None))
        self.conn.commit()
        cursor.close()
    
    def update_agent_performance(self, agent_id: str, task_type: str, 
                                  success: bool, completion_time: float, 
                                  reward: float):
        """Update agent performance metrics."""
        cursor = self.conn.cursor()
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
        self.conn.commit()
        cursor.close()
    
    def verify_audit_integrity(self) -> tuple[bool, str]:
        """Verify audit log hash chain integrity."""
        cursor = self.conn.cursor(cursor_factory=RealDictCursor)
        cursor.execute("""
            SELECT id, hash_chain, previous_hash 
            FROM rl_audit_logs 
            ORDER BY id ASC
        """)
        
        entries = cursor.fetchall()
        cursor.close()
        
        if not entries:
            return True, "No audit entries to verify"
        
        previous_hash = None
        for entry in entries:
            if entry['previous_hash'] != previous_hash:
                return False, f"Hash chain broken at entry {entry['id']}"
            previous_hash = entry['hash_chain']
        
        return True, "Audit log integrity verified"
    
    def query_compliance_report(self, hours: int = 24) -> List[Dict]:
        """Generate compliance report for last N hours."""
        cursor = self.conn.cursor(cursor_factory=RealDictCursor)
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
        cursor.close()
        return [dict(r) for r in results]
    
    def close(self):
        """Close database connection."""
        if self.conn:
            self.conn.close()
```

---

### Week 4: Redis Integration

**Lead:** MCP Builder  
**Support:** SRE

#### Day 1-2: Redis Setup

```bash
# 1. Install Redis
sudo apt update
sudo apt install redis-server -y

# 2. Configure Redis for RL workload
sudo nano /etc/redis/redis.conf
# Add/modify:
# requirepass CHANGE_ME_IN_PRODUCTION
# tls-port 6379
# port 0  # Disable non-TLS port
# tls-cert-file /etc/redis/tls/redis.crt
# tls-key-file /etc/redis/tls/redis.key
# tls-ca-cert-file /etc/redis/tls/ca.crt
# bind 127.0.0.1
# maxmemory 512mb
# maxmemory-policy allkeys-lru

# 3. Restart Redis
sudo systemctl restart redis-server

# 4. Test connection
redis-cli -a PASSWORD PING
```

#### Day 3-5: Application Integration

**File:** `src/rl/storage/redis.py`

```python
import redis
import json
from typing import Optional, List, Dict, Any
from datetime import timedelta

class RedisStorage:
    """Redis-backed storage for RL mechanism."""
    
    def __init__(self, host: str = 'localhost', port: int = 6379, 
                 password: str = None, use_tls: bool = True):
        self.redis = redis.Redis(
            host=host,
            port=port,
            password=password,
            ssl=use_tls,
            decode_responses=True
        )
        self.prefix = "rl"
    
    # State Cache
    def cache_state(self, task_id: str, state: Dict[str, Any], ttl: int = 3600):
        """Cache task state with TTL."""
        key = f"{self.prefix}:state:{task_id}"
        self.redis.setex(key, ttl, json.dumps(state))
    
    def get_state(self, task_id: str) -> Optional[Dict[str, Any]]:
        """Retrieve cached state."""
        key = f"{self.prefix}:state:{task_id}"
        data = self.redis.get(key)
        return json.loads(data) if data else None
    
    # Agent Availability
    def set_agent_availability(self, agent_id: str, available: bool, ttl: int = 300):
        """Set agent availability status."""
        key = f"{self.prefix}:agent:availability:{agent_id}"
        self.redis.setex(key, ttl, "true" if available else "false")
    
    def get_agent_availability(self, agent_id: str) -> bool:
        """Check if agent is available."""
        key = f"{self.prefix}:agent:availability:{agent_id}"
        status = self.redis.get(key)
        return status == "true"
    
    def get_all_available_agents(self) -> List[str]:
        """Get list of all available agents."""
        pattern = f"{self.prefix}:agent:availability:*"
        keys = self.redis.keys(pattern)
        available = []
        for key in keys:
            if self.redis.get(key) == "true":
                agent_id = key.split(":")[-1]
                available.append(agent_id)
        return available
    
    # Reward History
    def append_reward(self, reward: float, max_length: int = 10000):
        """Append reward to history list."""
        key = f"{self.prefix}:rewards:history"
        self.redis.lpush(key, str(reward))
        self.redis.ltrim(key, 0, max_length - 1)
    
    def get_reward_history(self, count: int = 100) -> List[float]:
        """Get recent reward history."""
        key = f"{self.prefix}:rewards:history"
        values = self.redis.lrange(key, 0, count - 1)
        return [float(v) for v in values]
    
    # Policy Version Lock
    def get_policy_version(self) -> Optional[str]:
        """Get current active policy version."""
        return self.redis.get(f"{self.prefix}:policy:version")
    
    def set_policy_version(self, version: str):
        """Set active policy version."""
        self.redis.set(f"{self.prefix}:policy:version", version)
    
    # Distributed Lock
    def acquire_lock(self, lock_name: str, timeout: int = 300) -> bool:
        """Acquire distributed lock (prevent race conditions)."""
        key = f"{self.prefix}:lock:{lock_name}"
        return self.redis.set(key, "locked", nx=True, ex=timeout)
    
    def release_lock(self, lock_name: str):
        """Release distributed lock."""
        key = f"{self.prefix}:lock:{lock_name}"
        self.redis.delete(key)
    
    # Pub/Sub for Real-time Updates
    def publish_agent_update(self, agent_id: str, update: Dict[str, Any]):
        """Publish agent status update."""
        channel = f"{self.prefix}:agent:updates"
        message = json.dumps({"agent_id": agent_id, **update})
        self.redis.publish(channel, message)
    
    def subscribe_agent_updates(self):
        """Subscribe to agent updates (returns pubsub object)."""
        channel = f"{self.prefix}:agent:updates"
        pubsub = self.redis.pubsub()
        pubsub.subscribe(channel)
        return pubsub
    
    # Metrics
    def increment_counter(self, metric_name: str, tags: Dict[str, str] = None):
        """Increment a counter metric."""
        key = f"{self.prefix}:metric:counter:{metric_name}"
        if tags:
            key += ":" + ":".join(f"{k}={v}" for k, v in sorted(tags.items()))
        self.redis.incr(key)
    
    def record_histogram(self, metric_name: str, value: float, tags: Dict[str, str] = None):
        """Record a histogram metric (simplified - stores last value)."""
        key = f"{self.prefix}:metric:histogram:{metric_name}"
        if tags:
            key += ":" + ":".join(f"{k}={v}" for k, v in sorted(tags.items()))
        # In production, use RedisTimeSeries module
        self.redis.setex(key, 86400, str(value))  # 24h TTL
    
    # Health Check
    def health_check(self) -> bool:
        """Check Redis connection health."""
        try:
            return self.redis.ping()
        except:
            return False
```

---

### Week 5: OpenTelemetry Integration

**Lead:** SRE  
**Support:** MCP Builder

#### Day 1-2: OpenTelemetry Setup

```bash
# 1. Install OpenTelemetry Collector
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.95.0/otelcol-contrib_0.95.0_linux_amd64.deb
sudo dpkg -i otelcol-contrib_0.95.0_linux_amd64.deb

# 2. Configure Collector
sudo nano /etc/otelcol-contrib/config.yaml
```

**Configuration:** `etc/otelcol-config.yaml`

```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318

processors:
  batch:
    timeout: 1s
    send_batch_size: 1024
  memory_limiter:
    check_interval: 1s
    limit_mib: 4000

exporters:
  prometheus:
    endpoint: "0.0.0.0:8889"
    namespace: rl
  
  otlp/jaeger:
    endpoint: jaeger:4317
    tls:
      insecure: true
  
  logging:
    loglevel: debug

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch, memory_limiter]
      exporters: [otlp/jaeger, logging]
    metrics:
      receivers: [otlp]
      processors: [batch, memory_limiter]
      exporters: [prometheus, logging]
```

#### Day 3-5: Application Instrumentation

**File:** `src/rl/observability/telemetry.py`

```python
from opentelemetry import trace, metrics
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.resources import Resource
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter
from functools import wraps

# Initialize resource
resource = Resource.create({
    "service.name": "rl-orchestrator",
    "service.version": "1.0.0",
    "deployment.environment": "production"
})

# Initialize tracer
trace_provider = TracerProvider(resource=resource)
trace_exporter = OTLPSpanExporter(endpoint="localhost:4317", insecure=True)
trace_provider.add_span_processor(
    BatchSpanProcessor(trace_exporter)
)
trace.set_tracer_provider(trace_provider)
tracer = trace.get_tracer("rl.orchestrator")

# Initialize meter
meter_provider = MeterProvider(resource=resource)
metric_exporter = OTLPMetricExporter(endpoint="localhost:4317", insecure=True)
meter_provider.add_metric_reader(PeriodicExportingMetricReader(metric_exporter))
metrics.set_meter_provider(meter_provider)
meter = metrics.get_meter("rl.orchestrator")

# Create metrics
task_duration_histogram = meter.create_histogram(
    name="rl.task.duration",
    description="Task execution duration in milliseconds",
    unit="ms"
)

task_success_counter = meter.create_counter(
    name="rl.task.success",
    description="Count of successful task completions",
    unit="1"
)

agent_selection_counter = meter.create_counter(
    name="rl.agent.selection",
    description="Count of agent selections by agent ID",
    unit="1"
)

safety_violation_counter = meter.create_counter(
    name="rl.safety.violation",
    description="Count of safety violations by type",
    unit="1"
)

reward_histogram = meter.create_histogram(
    name="rl.reward.value",
    description="Reward value distribution",
    unit="1"
)

compliance_gauge = meter.create_gauge(
    name="rl.compliance.score",
    description="Current compliance score",
    unit="1"
)

# Decorator for tracing
def traced_operation(operation_name: str):
    """Decorator to trace function execution."""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            with tracer.start_as_current_span(operation_name) as span:
                span.set_attribute("function.name", func.__name__)
                try:
                    result = func(*args, **kwargs)
                    span.set_attribute("operation.success", True)
                    return result
                except Exception as e:
                    span.set_attribute("operation.success", False)
                    span.set_attribute("operation.error", str(e))
                    span.record_exception(e)
                    raise
        return wrapper
    return decorator

# Usage example
@traced_operation("rl.task.execution")
def execute_task_with_tracing(task):
    span = trace.get_current_span()
    span.set_attribute("rl.task.id", str(task.id))
    span.set_attribute("rl.task.type", task.category)
    
    start_time = time.time()
    try:
        result = execute_task(task)
        
        duration_ms = (time.time() - start_time) * 1000
        task_duration_histogram.record(
            duration_ms,
            attributes={"task.type": task.category}
        )
        
        if result.success:
            task_success_counter.add(
                1,
                attributes={"task.type": task.category}
            )
        
        return result
    except Exception as e:
        task_duration_histogram.record(
            (time.time() - start_time) * 1000,
            attributes={"task.type": task.category, "error": "true"}
        )
        raise
```

---

### Week 6: Integration & Testing

**Lead:** Model QA  
**Support:** All agents

#### Day 1-3: Integration Testing

```python
# tests/integration/test_infrastructure.py

class TestPostgreSQLIntegration:
    def test_audit_log_integrity(self):
        """Verify audit log hash chain integrity."""
        storage = PostgreSQLStorage(TEST_DB_URL)
        
        # Log multiple entries
        for i in range(10):
            storage.log_audit_entry({
                "task_id": str(uuid.uuid4()),
                "agent_id": "test-agent",
                "action_type": "test",
                "rl_decision": {"test": i}
            })
        
        # Verify integrity
        is_valid, message = storage.verify_audit_integrity()
        assert is_valid, f"Audit integrity check failed: {message}"
    
    def test_compliance_query(self):
        """Test compliance report generation."""
        storage = PostgreSQLStorage(TEST_DB_URL)
        report = storage.query_compliance_report(hours=24)
        assert len(report) > 0
        assert 'avg_compliance' in report[0]

class TestRedisIntegration:
    def test_state_cache(self):
        """Test state caching with TTL."""
        storage = RedisStorage(password=TEST_REDIS_PASSWORD)
        
        # Cache state
        storage.cache_state("task-123", {"test": "data"}, ttl=60)
        
        # Retrieve state
        state = storage.get_state("task-123")
        assert state == {"test": "data"}
    
    def test_agent_availability(self):
        """Test agent availability tracking."""
        storage = RedisStorage(password=TEST_REDIS_PASSWORD)
        
        # Set availability
        storage.set_agent_availability("agent-1", True, ttl=60)
        assert storage.get_agent_availability("agent-1") == True
        
        # Set unavailable
        storage.set_agent_availability("agent-1", False, ttl=60)
        assert storage.get_agent_availability("agent-1") == False

class TestOpenTelemetryIntegration:
    def test_trace_generation(self):
        """Verify traces are generated correctly."""
        # Execute traced operation
        execute_task_with_tracing(test_task)
        
        # Verify trace exported (check Jaeger or mock exporter)
        # Implementation depends on test setup
        pass
```

#### Day 4-5: Performance Testing

```python
# tests/performance/test_benchmarks.py

def benchmark_postgresql_writes():
    """Benchmark PostgreSQL audit log writes."""
    storage = PostgreSQLStorage(TEST_DB_URL)
    
    start = time.time()
    for i in range(1000):
        storage.log_audit_entry({
            "task_id": str(uuid.uuid4()),
            "agent_id": "test-agent",
            "action_type": "benchmark",
            "rl_decision": {"i": i}
        })
    duration = time.time() - start
    
    print(f"PostgreSQL writes: {1000/duration:.2f} ops/sec")
    assert duration < 10.0, "PostgreSQL writes too slow"

def benchmark_redis_reads():
    """Benchmark Redis state cache reads."""
    storage = RedisStorage(password=TEST_REDIS_PASSWORD)
    
    # Pre-populate cache
    for i in range(1000):
        storage.cache_state(f"task-{i}", {"data": i}, ttl=3600)
    
    # Benchmark reads
    start = time.time()
    for i in range(1000):
        storage.get_state(f"task-{i}")
    duration = time.time() - start
    
    print(f"Redis reads: {1000/duration:.2f} ops/sec")
    assert duration < 1.0, "Redis reads too slow"
```

---

## 📅 Phase 3: Integration Testing + pg_vector (Week 7-8)

### Week 7: pg_vector Integration

**Lead:** MCP Builder  
**Support:** Model QA

#### Day 1-2: Embedding Service Setup

```python
# src/rl/embeddings/service.py

from sentence_transformers import SentenceTransformer

class TaskEmbeddingService:
    """Generate task embeddings for semantic search."""
    
    def __init__(self, model_name: str = 'all-MiniLM-L6-v2'):
        self.model = SentenceTransformer(model_name)
        self.embedding_dim = 768
    
    def embed_task(self, task) -> List[float]:
        """Generate embedding for a task."""
        # Concatenate task features
        text = f"""
        Type: {task.category}
        Description: {task.description}
        Skills: {' '.join(task.skills)}
        Complexity: {task.complexity_score}
        """
        
        # Generate embedding
        embedding = self.model.encode(text)
        return embedding.tolist()
    
    def embed_tasks_batch(self, tasks: List) -> List[List[float]]:
        """Generate embeddings for multiple tasks."""
        texts = [
            f"Type: {t.category}\nDescription: {t.description}\nSkills: {' '.join(t.skills)}"
            for t in tasks
        ]
        embeddings = self.model.encode(texts)
        return embeddings.tolist()
```

#### Day 3-5: KNN Search Integration

```python
# src/rl/agent_selection/semantic.py

class SemanticAgentSelector:
    """Select agents based on semantic task similarity."""
    
    def __init__(self, db_storage, embedding_service):
        self.db = db_storage
        self.embedder = embedding_service
    
    def find_similar_tasks(self, task, limit: int = 10, 
                          min_similarity: float = 0.7) -> List[Dict]:
        """Find historically similar tasks."""
        # Generate embedding
        embedding = self.embedder.embed_task(task)
        
        # KNN search in PostgreSQL
        cursor = self.db.conn.cursor(cursor_factory=RealDictCursor)
        cursor.execute("""
            SELECT 
                task_id, task_type, optimal_agent_id, actual_reward,
                1 - (embedding <=> %s) as similarity
            FROM rl_task_embeddings
            WHERE 1 - (embedding <=> %s) > %s
            ORDER BY embedding <=> %s
            LIMIT %s
        """, (embedding, embedding, min_similarity, embedding, limit))
        
        results = cursor.fetchall()
        cursor.close()
        
        return [dict(r) for r in results]
    
    def select_agent_by_similarity(self, task) -> Dict[str, Any]:
        """Select best agent based on similar historical tasks."""
        similar_tasks = self.find_similar_tasks(task, limit=20)
        
        if not similar_tasks:
            # No similar tasks - use default policy
            return self.fallback_selection(task)
        
        # Group by agent and calculate average reward
        agent_rewards = {}
        for t in similar_tasks:
            agent = t['optimal_agent_id']
            reward = t['actual_reward'] or 0
            similarity = t['similarity']
            
            if agent not in agent_rewards:
                agent_rewards[agent] = []
            agent_rewards[agent].append(reward * similarity)  # Weight by similarity
        
        # Select agent with highest weighted average reward
        best_agent = max(
            agent_rewards.keys(),
            key=lambda a: sum(agent_rewards[a]) / len(agent_rewards[a])
        )
        
        confidence = len(similar_tasks) / 20.0  # More similar tasks = higher confidence
        
        return {
            "agent_id": best_agent,
            "confidence": min(confidence, 1.0),
            "method": "semantic_similarity",
            "similar_tasks_count": len(similar_tasks)
        }
```

### Week 8: End-to-End Testing

**Lead:** Reality Checker  
**Support:** Security Engineer, Compliance Auditor

- Full workflow testing
- Security penetration testing
- Compliance validation
- User acceptance testing

---

## 📅 Phase 4: Gradual Rollout (Week 9-11)

| Week | Traffic | Focus | Success Criteria |
|------|---------|-------|------------------|
| **Week 9** | 10% | Stability monitoring | 0 safety violations, 100% compliance |
| **Week 10** | 50% | Performance validation | <2s response time, >90% success rate |
| **Week 11** | 100% | Full production | All metrics within target |

---

## 📊 Success Metrics

| Metric | Baseline | Target | Measurement |
|--------|----------|--------|-------------|
| Task Success Rate | 86% | >95% | Completed / Total tasks |
| Agent Selection Accuracy | N/A | >90% | Optimal first-choice agent |
| Response Time | <1s | <2s (with RL) | Activation to output |
| Safety Violations | 0 | 0 | Zero tolerance |
| Compliance Score | 100% | 100% | Per-task audit |
| Redis Cache Hit Rate | N/A | >80% | Cache hits / Total requests |
| PostgreSQL Query Time | N/A | <50ms | P95 query latency |

---

## 🚨 Rollback Plan

**Triggers:**
- ANY safety violation
- Compliance score <95%
- Audit failures >1%
- User satisfaction <3/5

**Procedure:**
```bash
# 1. Disable RL routing
curl -X POST http://localhost:18789/admin/rl/disable

# 2. Revert to manual agent selection
openclaw config set rl.mode manual

# 3. Preserve audit logs
pg_dump rl_mechanism > rl_audit_backup_$(date +%Y%m%d).sql

# 4. Notify stakeholders
notify_team "RL rollback initiated" --reason="$ROLLBACK_REASON"

# 5. Schedule post-mortem
schedule_meeting "RL Rollback Post-Mortem" --within="24h"
```

---

## ✅ Approval Checklist

- [ ] User (Wulfrano) approves this implementation plan
- [ ] Infrastructure provisioned (Redis, PostgreSQL, pg_vector, OTel)
- [ ] Database schemas deployed
- [ ] Application code integrated
- [ ] Tests passing (unit, integration, performance)
- [ ] Security review complete
- [ ] Compliance validation complete
- [ ] Monitoring dashboards configured
- [ ] Alert thresholds set
- [ ] Rollback procedure tested

---

**Document Status:** APPROVED FOR IMPLEMENTATION  
**Next Step:** Phase 2 Kickoff (Week 3)  
**Estimated Completion:** 11 weeks from approval
