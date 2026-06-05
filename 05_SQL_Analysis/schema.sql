-- ============================================================
-- IT Metrics Dashboard — SQL Server Schema
-- Author: Harshall Bhavsar | Business Analyst Portfolio
-- Database: ITMetricsDashboard
-- ============================================================

-- Create database (run once)
-- CREATE DATABASE ITMetricsDashboard;
-- GO
-- USE ITMetricsDashboard;
-- GO

-- Drop table if re-running
IF OBJECT_ID('dbo.incidents', 'U') IS NOT NULL
    DROP TABLE dbo.incidents;
GO

CREATE TABLE dbo.incidents (
    incident_id         VARCHAR(20)     NOT NULL PRIMARY KEY,
    title               VARCHAR(255)    NOT NULL,
    category            VARCHAR(50)     NOT NULL,
    priority            CHAR(2)         NOT NULL,        -- P1, P2, P3, P4
    assigned_to         VARCHAR(100)    NOT NULL,
    created_at          DATETIME        NOT NULL,
    resolved_at         DATETIME        NULL,
    mttr_hours          DECIMAL(6,1)    NULL,            -- Mean Time To Resolve in hours
    sla_target_hours    INT             NOT NULL,        -- SLA threshold in hours
    sla_met             VARCHAR(3)      NOT NULL,        -- Yes / No
    status              VARCHAR(20)     NOT NULL         -- Closed / Resolved / Open
);
GO

-- ============================================================
-- IMPORT INSTRUCTIONS
-- ============================================================
-- Option 1: SQL Server Management Studio (SSMS)
--   Right-click database > Tasks > Import Flat File
--   Select sample_incidents.csv, map columns, import.
--
-- Option 2: BULK INSERT (update file path before running)
--   BULK INSERT dbo.incidents
--   FROM 'C:\your\path\sample_incidents.csv'
--   WITH (
--       FIRSTROW = 2,
--       FIELDTERMINATOR = ',',
--       ROWTERMINATOR = '\n',
--       TABLOCK
--   );
-- GO
-- ============================================================
