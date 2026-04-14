-- RL Mechanism - Initial Database Schema
-- Version: 1.0
-- Date: April 14, 2026
-- Description: Core tables for RL mechanism audit logs, metrics, preferences, and performance tracking

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS vector;
CREATE EXTENSION IF NOT EXISTS pgaudit;

-- ============================================================================
-- AUDIT LOGS TABLE (Tamper-evident with hash chain)
-- ============================================================================

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

-- ============================================================================
-- METRICS TABLE (Time-series with partitioning)
-- ============================================================================

CREATE TABLE rl_metrics (
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    metric_name VARCHAR(64) NOT NULL,
    metric_value DECIMAL(10,6) NOT NULL,
    tags JSONB,
    partition_date DATE DEFAULT CURRENT_DATE
) PARTITION BY RANGE (partition_date);

-- Create monthly partitions (6 months ahead)
CREATE TABLE rl_metrics_2026_04 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE rl_metrics_2026_05 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');
CREATE TABLE rl_metrics_2026_06 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');
CREATE TABLE rl_metrics_2026_07 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');
CREATE TABLE rl_metrics_2026_08 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-08-01') TO ('2026-09-01');
CREATE TABLE rl_metrics_2026_09 PARTITION OF rl_metrics
    FOR VALUES FROM ('2026-09-01') TO ('2026-10-01');

-- Index for common queries
CREATE INDEX idx_metrics_name_time ON rl_metrics(metric_name, timestamp DESC);

-- ============================================================================
-- USER PREFERENCES TABLE (Encrypted)
-- ============================================================================

CREATE TABLE rl_user_preferences (
    workspace_id UUID PRIMARY KEY,
    preferences_encrypted BYTEA NOT NULL,  -- AES-256 encrypted
    encryption_key_id VARCHAR(64) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    last_reset_at TIMESTAMPTZ
);

-- ============================================================================
-- AGENT PERFORMANCE TABLE
-- ============================================================================

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

-- ============================================================================
-- TASK EMBEDDINGS TABLE (For pg_vector semantic search)
-- ============================================================================

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

-- ============================================================================
-- AGENT SELECTIONS HISTORY
-- ============================================================================

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

-- ============================================================================
-- SAFETY VIOLATIONS LOG
-- ============================================================================

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

-- ============================================================================
-- RL POLICY VERSIONS
-- ============================================================================

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

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for preferences table
CREATE TRIGGER update_preferences_updated_at
    BEFORE UPDATE ON rl_user_preferences
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- PERMISSIONS
-- ============================================================================

-- Grant permissions to rl_app user (assumes user already exists)
-- If user doesn't exist, create with: CREATE USER rl_app WITH ENCRYPTED PASSWORD 'CHANGE_ME';
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO rl_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO rl_app;

-- ============================================================================
-- INITIAL DATA
-- ============================================================================

-- Insert default policy version
INSERT INTO rl_policy_versions (version, created_by, model_architecture, is_active)
VALUES ('v1.0.0', 'system', 'PPO', TRUE);

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE rl_audit_logs IS 'Tamper-evident audit log with hash chain for RL mechanism';
COMMENT ON TABLE rl_metrics IS 'Time-series metrics with monthly partitioning';
COMMENT ON TABLE rl_user_preferences IS 'Encrypted user preferences (AES-256)';
COMMENT ON TABLE rl_agent_performance IS 'Agent performance metrics by task type';
COMMENT ON TABLE rl_task_embeddings IS 'Task embeddings for semantic similarity search (pg_vector)';
COMMENT ON TABLE rl_agent_selections IS 'History of agent selections and outcomes';
COMMENT ON TABLE rl_safety_violations IS 'Safety violation log with resolution tracking';
COMMENT ON TABLE rl_policy_versions IS 'RL policy version tracking with rollback support';

COMMENT ON COLUMN rl_audit_logs.hash_chain IS 'SHA-256 hash of entry + previous hash for tamper-evidence';
COMMENT ON COLUMN rl_audit_logs.previous_hash IS 'Hash of previous entry in chain';
COMMENT ON COLUMN rl_task_embeddings.embedding IS '768-dimensional embedding vector (all-MiniLM-L6-v2)';
COMMENT ON COLUMN rl_user_preferences.preferences_encrypted IS 'AES-256 encrypted preferences blob';

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Verify all tables created
-- SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;

-- Verify indexes
-- SELECT indexname, tablename FROM pg_indexes WHERE schemaname = 'public' ORDER BY tablename, indexname;

-- Verify extensions
-- SELECT extname FROM pg_extension;

-- Verify audit log integrity function works
-- SELECT verify_audit_integrity();  -- (function to be created in application layer)
