"""
RL Mechanism - Redis Storage Backend

Provides fast, persistent state caching, agent availability tracking,
and distributed locking for the RL mechanism.
"""

import redis
import json
from typing import Optional, List, Dict, Any
from datetime import timedelta
import logging

logger = logging.getLogger(__name__)


class RedisStorage:
    """
    Redis-backed storage for RL mechanism.
    
    Features:
    - State caching with TTL
    - Agent availability tracking
    - Reward history
    - Distributed locking
    - Pub/Sub for real-time updates
    - Metrics counters and histograms
    """
    
    def __init__(self, host: str = 'localhost', port: int = 6380, 
                 password: str = None, use_tls: bool = True,
                 tls_ca: str = None, tls_cert: str = None, tls_key: str = None):
        """
        Initialize Redis storage.
        
        Args:
            host: Redis host
            port: Redis port (TLS: 6380, non-TLS: 6379)
            password: Redis password
            use_tls: Use TLS connection
            tls_ca: CA certificate path
            tls_cert: Client certificate path
            tls_key: Client key path
        """
        self.prefix = "rl"
        
        # Build connection parameters
        connection_kwargs = {
            'host': host,
            'port': port,
            'password': password,
            'decode_responses': True,
            'ssl': use_tls,
        }
        
        # Add TLS certificates if provided
        if use_tls and tls_ca:
            connection_kwargs['ssl_ca_certs'] = tls_ca
        if use_tls and tls_cert:
            connection_kwargs['ssl_certfile'] = tls_cert
        if use_tls and tls_key:
            connection_kwargs['ssl_keyfile'] = tls_key
        
        self.redis = redis.Redis(**connection_kwargs)
        
        # Test connection
        try:
            self.redis.ping()
            logger.info(f"Redis connection established (host={host}:{port}, tls={use_tls})")
        except redis.ConnectionError as e:
            logger.error(f"Redis connection failed: {e}")
            raise
    
    # =========================================================================
    # STATE CACHE
    # =========================================================================
    
    def cache_state(self, task_id: str, state: Dict[str, Any], ttl: int = 3600):
        """
        Cache task state with TTL.
        
        Args:
            task_id: Task identifier
            state: State dictionary to cache
            ttl: Time-to-live in seconds (default: 1 hour)
        """
        key = f"{self.prefix}:state:{task_id}"
        self.redis.setex(key, ttl, json.dumps(state))
        logger.debug(f"State cached: {task_id} (TTL={ttl}s)")
    
    def get_state(self, task_id: str) -> Optional[Dict[str, Any]]:
        """
        Retrieve cached state.
        
        Args:
            task_id: Task identifier
        
        Returns:
            State dictionary or None if not found
        """
        key = f"{self.prefix}:state:{task_id}"
        data = self.redis.get(key)
        
        if data:
            logger.debug(f"State retrieved: {task_id}")
            return json.loads(data)
        else:
            logger.debug(f"State cache miss: {task_id}")
            return None
    
    def delete_state(self, task_id: str):
        """Delete cached state."""
        key = f"{self.prefix}:state:{task_id}"
        self.redis.delete(key)
        logger.debug(f"State deleted: {task_id}")
    
    # =========================================================================
    # AGENT AVAILABILITY
    # =========================================================================
    
    def set_agent_availability(self, agent_id: str, available: bool, ttl: int = 300):
        """
        Set agent availability status.
        
        Args:
            agent_id: Agent identifier
            available: Availability status
            ttl: Time-to-live in seconds (default: 5 minutes)
        """
        key = f"{self.prefix}:agent:availability:{agent_id}"
        self.redis.setex(key, ttl, "true" if available else "false")
        logger.debug(f"Agent availability set: {agent_id}={available}")
    
    def get_agent_availability(self, agent_id: str) -> bool:
        """
        Check if agent is available.
        
        Args:
            agent_id: Agent identifier
        
        Returns:
            True if available, False otherwise
        """
        key = f"{self.prefix}:agent:availability:{agent_id}"
        status = self.redis.get(key)
        return status == "true"
    
    def get_all_available_agents(self) -> List[str]:
        """
        Get list of all available agents.
        
        Returns:
            List of available agent IDs
        """
        pattern = f"{self.prefix}:agent:availability:*"
        keys = self.redis.keys(pattern)
        available = []
        
        for key in keys:
            if self.redis.get(key) == "true":
                agent_id = key.split(":")[-1]
                available.append(agent_id)
        
        logger.debug(f"Available agents: {len(available)}")
        return available
    
    # =========================================================================
    # REWARD HISTORY
    # =========================================================================
    
    def append_reward(self, reward: float, max_length: int = 10000):
        """
        Append reward to history list.
        
        Args:
            reward: Reward value
            max_length: Maximum list length (default: 10,000)
        """
        key = f"{self.prefix}:rewards:history"
        self.redis.lpush(key, str(reward))
        self.redis.ltrim(key, 0, max_length - 1)
        logger.debug(f"Reward appended: {reward}")
    
    def get_reward_history(self, count: int = 100) -> List[float]:
        """
        Get recent reward history.
        
        Args:
            count: Number of rewards to retrieve
        
        Returns:
            List of reward values
        """
        key = f"{self.prefix}:rewards:history"
        values = self.redis.lrange(key, 0, count - 1)
        return [float(v) for v in values]
    
    def get_reward_stats(self) -> Dict[str, float]:
        """
        Calculate reward statistics.
        
        Returns:
            Dictionary with mean, min, max, count
        """
        history = self.get_reward_history(count=1000)
        
        if not history:
            return {'mean': 0, 'min': 0, 'max': 0, 'count': 0}
        
        return {
            'mean': sum(history) / len(history),
            'min': min(history),
            'max': max(history),
            'count': len(history)
        }
    
    # =========================================================================
    # POLICY VERSION
    # =========================================================================
    
    def get_policy_version(self) -> Optional[str]:
        """Get current active policy version."""
        return self.redis.get(f"{self.prefix}:policy:version")
    
    def set_policy_version(self, version: str):
        """Set active policy version."""
        self.redis.set(f"{self.prefix}:policy:version", version)
        logger.info(f"Policy version set: {version}")
    
    # =========================================================================
    # DISTRIBUTED LOCK
    # =========================================================================
    
    def acquire_lock(self, lock_name: str, timeout: int = 300) -> bool:
        """
        Acquire distributed lock (prevent race conditions).
        
        Args:
            lock_name: Lock identifier
            timeout: Lock timeout in seconds
        
        Returns:
            True if lock acquired, False otherwise
        """
        key = f"{self.prefix}:lock:{lock_name}"
        acquired = self.redis.set(key, "locked", nx=True, ex=timeout)
        
        if acquired:
            logger.debug(f"Lock acquired: {lock_name}")
        else:
            logger.debug(f"Lock busy: {lock_name}")
        
        return acquired
    
    def release_lock(self, lock_name: str):
        """Release distributed lock."""
        key = f"{self.prefix}:lock:{lock_name}"
        self.redis.delete(key)
        logger.debug(f"Lock released: {lock_name}")
    
    @contextmanager
    def lock(self, lock_name: str, timeout: int = 300):
        """
        Context manager for distributed lock.
        
        Usage:
            with redis_storage.lock("training"):
                # Critical section
                train_model()
        """
        acquired = self.acquire_lock(lock_name, timeout)
        if not acquired:
            raise RuntimeError(f"Failed to acquire lock: {lock_name}")
        
        try:
            yield
        finally:
            self.release_lock(lock_name)
    
    # =========================================================================
    # PUB/SUB
    # =========================================================================
    
    def publish_agent_update(self, agent_id: str, update: Dict[str, Any]):
        """
        Publish agent status update.
        
        Args:
            agent_id: Agent identifier
            update: Update dictionary
        """
        channel = f"{self.prefix}:agent:updates"
        message = json.dumps({"agent_id": agent_id, **update})
        self.redis.publish(channel, message)
        logger.debug(f"Agent update published: {agent_id}")
    
    def subscribe_agent_updates(self):
        """
        Subscribe to agent updates.
        
        Returns:
            Redis pubsub object
        """
        channel = f"{self.prefix}:agent:updates"
        pubsub = self.redis.pubsub()
        pubsub.subscribe(channel)
        logger.info(f"Subscribed to agent updates: {channel}")
        return pubsub
    
    # =========================================================================
    # METRICS
    # =========================================================================
    
    def increment_counter(self, metric_name: str, tags: Dict[str, str] = None,
                         value: int = 1):
        """
        Increment a counter metric.
        
        Args:
            metric_name: Metric name
            tags: Optional tags for filtering
            value: Increment value (default: 1)
        """
        key = f"{self.prefix}:metric:counter:{metric_name}"
        if tags:
            key += ":" + ":".join(f"{k}={v}" for k, v in sorted(tags.items()))
        
        self.redis.incrby(key, value)
        logger.debug(f"Counter incremented: {key} (+{value})")
    
    def get_counter(self, metric_name: str, tags: Dict[str, str] = None) -> int:
        """Get counter value."""
        key = f"{self.prefix}:metric:counter:{metric_name}"
        if tags:
            key += ":" + ":".join(f"{k}={v}" for k, v in sorted(tags.items()))
        
        value = self.redis.get(key)
        return int(value) if value else 0
    
    def record_histogram(self, metric_name: str, value: float, 
                        tags: Dict[str, str] = None):
        """
        Record a histogram metric (simplified - stores last value).
        
        Note: For production, use RedisTimeSeries module.
        
        Args:
            metric_name: Metric name
            value: Metric value
            tags: Optional tags
        """
        key = f"{self.prefix}:metric:histogram:{metric_name}"
        if tags:
            key += ":" + ":".join(f"{k}={v}" for k, v in sorted(tags.items()))
        
        # 24h TTL
        self.redis.setex(key, 86400, str(value))
        logger.debug(f"Histogram recorded: {metric_name}={value}")
    
    # =========================================================================
    # HEALTH CHECK
    # =========================================================================
    
    def health_check(self) -> bool:
        """Check Redis connection health."""
        try:
            return self.redis.ping()
        except Exception as e:
            logger.error(f"Redis health check failed: {e}")
            return False
    
    def get_memory_info(self) -> Dict[str, Any]:
        """Get Redis memory usage information."""
        info = self.redis.info('memory')
        return {
            'used_memory': info.get('used_memory', 0),
            'used_memory_human': info.get('used_memory_human', '0B'),
            'used_memory_peak': info.get('used_memory_peak', 0),
            'used_memory_peak_human': info.get('used_memory_peak_human', '0B'),
            'maxmemory': info.get('maxmemory', 0),
            'maxmemory_human': info.get('maxmemory_human', '0B'),
        }
    
    def get_stats(self) -> Dict[str, Any]:
        """Get Redis statistics."""
        return {
            'memory': self.get_memory_info(),
            'connected_clients': self.redis.info('clients').get('connected_clients', 0),
            'uptime_seconds': self.redis.info('server').get('uptime_in_seconds', 0),
        }
