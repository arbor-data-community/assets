-- Simple SQL query to create a database in snowflake.

-- Define the database name
-- Replace 'MySnowflakeDB' with your desired database name
CREATE DATABASE MySnowflakeDB
    -- Optional: Clone from an existing source database, if applicable
    -- CLONE source_db [AT | BEFORE (TIMESTAMP => '2023-01-01 00:00:00')]

    -- Set data retention time in days (optional)
    DATA_RETENTION_TIME_IN_DAYS = 7

    -- Set maximum data extension time in days (optional)
    MAX_DATA_EXTENSION_TIME_IN_DAYS = 30

    -- Define default DDL collation (optional)
    -- DEFAULT_DDL_COLLATION = 'en-US'

    -- Add a descriptive comment (optional)
    COMMENT = 'Primary database for MAT-wide Analytics'

    -- Tagging the database (optional)
    -- TAG (department = 'analytics', project = 'data_migration');

-- Note: Adjust the above script based on your specific needs.
-- For example, if you need a transient database, add the TRANSIENT keyword at the beginning.
-- Make sure to replace placeholder values like 'MySnowflakeDB' with actual names relevant to your context.
