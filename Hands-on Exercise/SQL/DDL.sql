/* =============================================================================
   UNIVERSAL SQL DDL REFERENCE FILE
   Covers:
   - ANSI SQL standards
   - PostgreSQL, MySQL, SQL Server, Oracle extensions
   - Historical and modern DDL features
   - Educational examples for every concept
   ============================================================================= */


/* =============================================================================
   1. DATABASE / CATALOG LEVEL
   ============================================================================= */

/* Create database */
CREATE DATABASE example_db;

/* Create database with options (vendor-specific) */
-- PostgreSQL
CREATE DATABASE example_db_pg
    WITH OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8';

-- MySQL
CREATE DATABASE example_db_mysql
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

-- SQL Server
CREATE DATABASE example_db_mssql;
GO

/* Alter database */
ALTER DATABASE example_db SET READ ONLY;

/* Rename database */
ALTER DATABASE example_db RENAME TO example_db_renamed;

/* Drop database */
DROP DATABASE example_db_renamed;


/* =============================================================================
   2. SCHEMA / NAMESPACE
   ============================================================================= */

CREATE SCHEMA app;
CREATE SCHEMA IF NOT EXISTS reporting;

/* Authorization (ANSI / PostgreSQL / Oracle) */
CREATE SCHEMA secure AUTHORIZATION admin;

/* Alter schema */
ALTER SCHEMA app RENAME TO application;

/* Drop schema */
DROP SCHEMA reporting;
DROP SCHEMA application CASCADE;


/* =============================================================================
   3. TABLE CREATION (CORE)
   ============================================================================= */

CREATE TABLE users (
    id INTEGER,
    username VARCHAR(50),
    email VARCHAR(255),
    created_at TIMESTAMP
);

/* IF NOT EXISTS */
CREATE TABLE IF NOT EXISTS users_safe (
    id INTEGER
);

/* Fully qualified */
CREATE TABLE app.orders (
    id INTEGER,
    user_id INTEGER,
    total DECIMAL(10,2)
);


/* =============================================================================
   4. DATA TYPES (HISTORICAL + MODERN)
   ============================================================================= */

/* Numeric */
INTEGER
SMALLINT
BIGINT
DECIMAL(10,2)
NUMERIC(20,5)
FLOAT
REAL
DOUBLE PRECISION

/* Character */
CHAR(10)
VARCHAR(255)
TEXT
NCHAR
NVARCHAR

/* Date & Time */
DATE
TIME
TIMESTAMP
TIMESTAMP WITH TIME ZONE
INTERVAL

/* Boolean */
BOOLEAN

/* Binary / Large Objects */
BINARY
VARBINARY
BLOB
CLOB
BYTEA -- PostgreSQL

/* JSON */
JSON
JSONB -- PostgreSQL

/* XML */
XML

/* UUID */
UUID

/* Spatial / GIS */
GEOMETRY
GEOGRAPHY

/* Arrays (PostgreSQL) */
INTEGER[]
TEXT[]

/* Enums */
CREATE TYPE status_enum AS ENUM ('active', 'inactive');


/* =============================================================================
   5. CONSTRAINTS
   ============================================================================= */

CREATE TABLE constraints_example (
    id INTEGER PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    age INTEGER CHECK (age >= 18),
    role VARCHAR(20) DEFAULT 'user',
    manager_id INTEGER,
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
        REFERENCES constraints_example(id)
);

/* Composite primary key */
CREATE TABLE composite_pk (
    order_id INTEGER,
    product_id INTEGER,
    PRIMARY KEY (order_id, product_id)
);

/* Deferrable constraints */
CREATE TABLE deferrable_example (
    id INTEGER PRIMARY KEY,
    ref_id INTEGER,
    CONSTRAINT fk_ref
        FOREIGN KEY (ref_id)
        REFERENCES deferrable_example(id)
        DEFERRABLE INITIALLY DEFERRED
);


/* =============================================================================
   6. IDENTITY / AUTO-INCREMENT
   ============================================================================= */

/* ANSI SQL */
CREATE TABLE identity_example (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name TEXT
);

/* PostgreSQL SERIAL (legacy) */
CREATE TABLE serial_example (
    id SERIAL PRIMARY KEY
);

/* MySQL */
CREATE TABLE mysql_auto (
    id INT AUTO_INCREMENT PRIMARY KEY
);

/* SQL Server */
CREATE TABLE mssql_identity (
    id INT IDENTITY(1,1) PRIMARY KEY
);


/* =============================================================================
   7. TABLE INHERITANCE (PostgreSQL)
   ============================================================================= */

CREATE TABLE base_event (
    id INTEGER,
    created_at TIMESTAMP
);

CREATE TABLE user_event (
    user_id INTEGER
) INHERITS (base_event);


/* =============================================================================
   8. TEMPORARY & UNLOGGED TABLES
   ============================================================================= */

CREATE TEMP TABLE temp_data (
    value INTEGER
);

CREATE GLOBAL TEMPORARY TABLE session_data (
    key VARCHAR(50),
    value VARCHAR(255)
) ON COMMIT PRESERVE ROWS;

/* PostgreSQL */
CREATE UNLOGGED TABLE fast_table (
    id INTEGER
);


/* =============================================================================
   9. ALTER TABLE (ALL VARIANTS)
   ============================================================================= */

ALTER TABLE users ADD COLUMN last_login TIMESTAMP;
ALTER TABLE users DROP COLUMN last_login;
ALTER TABLE users ALTER COLUMN username SET NOT NULL;
ALTER TABLE users ALTER COLUMN username DROP NOT NULL;
ALTER TABLE users RENAME COLUMN username TO user_name;
ALTER TABLE users RENAME TO app_users;

/* Add constraint */
ALTER TABLE users
ADD CONSTRAINT uq_email UNIQUE (email);

/* Drop constraint */
ALTER TABLE users DROP CONSTRAINT uq_email;


/* =============================================================================
   10. INDEXES
   ============================================================================= */

CREATE INDEX idx_users_email ON users(email);
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);
CREATE INDEX idx_users_lower_email ON users (LOWER(email));

/* Partial index */
CREATE INDEX idx_active_users
ON users(email)
WHERE status = 'active';

/* Drop index */
DROP INDEX idx_users_email;


/* =============================================================================
   11. VIEWS
   ============================================================================= */

CREATE VIEW user_emails AS
SELECT id, email FROM users;

/* Replace view */
CREATE OR REPLACE VIEW user_emails AS
SELECT id, email, created_at FROM users;

/* Materialized view */
CREATE MATERIALIZED VIEW user_summary AS
SELECT COUNT(*) FROM users;

/* Drop view */
DROP VIEW user_emails;
DROP MATERIALIZED VIEW user_summary;


/* =============================================================================
   12. SEQUENCES
   ============================================================================= */

CREATE SEQUENCE order_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 10;

ALTER SEQUENCE order_seq RESTART WITH 100;
DROP SEQUENCE order_seq;


/* =============================================================================
   13. FUNCTIONS (DDL SIDE)
   ============================================================================= */

CREATE FUNCTION add_numbers(a INTEGER, b INTEGER)
RETURNS INTEGER
AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

/* Drop function */
DROP FUNCTION add_numbers;


/* =============================================================================
   14. PROCEDURES
   ============================================================================= */

CREATE PROCEDURE log_message(msg TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO logs(message) VALUES (msg);
END;
$$;

DROP PROCEDURE log_message;


/* =============================================================================
   15. TRIGGERS
   ============================================================================= */

CREATE FUNCTION set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_timestamp
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_timestamp();

DROP TRIGGER trg_update_timestamp ON users;


/* =============================================================================
   16. ROLES, USERS, PERMISSIONS
   ============================================================================= */

CREATE ROLE app_user;
CREATE USER john WITH PASSWORD 'secret';

GRANT SELECT, INSERT ON users TO app_user;
REVOKE INSERT ON users FROM app_user;

DROP USER john;
DROP ROLE app_user;


/* =============================================================================
   17. TABLESPACES
   ============================================================================= */

CREATE TABLESPACE fast_space
LOCATION '/data/fast';

ALTER TABLE users SET TABLESPACE fast_space;
DROP TABLESPACE fast_space;


/* =============================================================================
   18. PARTITIONING
   ============================================================================= */

CREATE TABLE sales (
    id INTEGER,
    sale_date DATE
) PARTITION BY RANGE (sale_date);

CREATE TABLE sales_2024 PARTITION OF sales
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');


/* =============================================================================
   19. COMMENTS & METADATA
   ============================================================================= */

COMMENT ON TABLE users IS 'Stores application users';
COMMENT ON COLUMN users.email IS 'Unique email address';


/* =============================================================================
   20. DROP / TRUNCATE
   ============================================================================= */

TRUNCATE TABLE users;
DROP TABLE users CASCADE;


/* =============================================================================
   END OF FILE
   ============================================================================= */
