-- ============================================================
-- BPO People Analytics — SQL Queries
-- Project: From Burnout to Retention
-- Author: Sigma Rose A. Abordo, RMT, ASCPi
-- Database: PostgreSQL 15
-- ============================================================

-- Tables:
--   agents     (agent_id, agent_name, team_name, shift, hire_date, employment_status)
--   calls      (call_id, agent_id, call_date, handle_time_sec, csat_score, resolved, sla_met)
--   attendance (attendance_id, agent_id, work_date, status, shift)


-- ============================================================
-- QUERY 1 — Average Handle Time (AHT) by Shift
-- Business Question: Which shift takes longest to handle calls?
-- ============================================================
SELECT
    a.shift,
    ROUND(AVG(c.handle_time_sec), 0) AS avg_handle_time_sec,
    COUNT(c.call_id) AS total_calls
FROM agents a
JOIN calls c ON a.agent_id = c.agent_id
GROUP BY a.shift
ORDER BY avg_handle_time_sec DESC;


-- ============================================================
-- QUERY 2 — Average CSAT Score by Team
-- Business Question: Which team has the lowest customer satisfaction?
-- ============================================================
SELECT
    a.team_name,
    ROUND(AVG(c.csat_score), 2) AS avg_csat_score,
    COUNT(c.call_id) AS total_calls
FROM agents a
JOIN calls c ON a.agent_id = c.agent_id
GROUP BY a.team_name
ORDER BY avg_csat_score ASC;


-- ============================================================
-- QUERY 3 — Call Resolution Rate by Shift
-- Business Question: Which shift resolves the fewest calls?
-- ============================================================
SELECT
    a.shift,
    COUNT(CASE WHEN c.resolved = 'Yes' THEN 1 END) AS resolved_calls,
    COUNT(c.call_id) AS total_calls,
    ROUND(
        100.0 * COUNT(CASE WHEN c.resolved = 'Yes' THEN 1 END) / COUNT(c.call_id),
        1
    ) AS resolution_rate_pct
FROM agents a
JOIN calls c ON a.agent_id = c.agent_id
GROUP BY a.shift
ORDER BY resolution_rate_pct ASC;


-- ============================================================
-- QUERY 4 — Absence Rate by Shift
-- Business Question: Which shift has the most absences?
-- ============================================================
SELECT
    shift,
    COUNT(CASE WHEN status = 'Absent' THEN 1 END) AS total_absences,
    COUNT(attendance_id) AS total_records,
    ROUND(
        100.0 * COUNT(CASE WHEN status = 'Absent' THEN 1 END) / COUNT(attendance_id),
        1
    ) AS absence_rate_pct
FROM attendance
GROUP BY shift
ORDER BY total_absences DESC;


-- ============================================================
-- QUERY 5 — Attrition Risk Score by Agent
-- Business Question: Which agents are at highest risk of leaving?
-- Logic: High AHT + Low CSAT + High absences = High risk
-- ============================================================
SELECT
    a.agent_name,
    a.team_name,
    a.shift,
    ROUND(AVG(c.handle_time_sec), 0) AS avg_aht,
    ROUND(AVG(c.csat_score), 2) AS avg_csat,
    COUNT(CASE WHEN att.status = 'Absent' THEN 1 END) AS absences,
    CASE
        WHEN AVG(c.csat_score) < 2.0
             AND AVG(c.handle_time_sec) > 400
             AND COUNT(CASE WHEN att.status = 'Absent' THEN 1 END) >= 2
        THEN 'High Risk'
        WHEN AVG(c.csat_score) < 3.0
             AND AVG(c.handle_time_sec) > 350
        THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS attrition_risk
FROM agents a
JOIN calls c ON a.agent_id = c.agent_id
LEFT JOIN attendance att ON a.agent_id = att.agent_id
GROUP BY a.agent_name, a.team_name, a.shift
ORDER BY avg_csat ASC, avg_aht DESC;


-- ============================================================
-- QUERY 6 — Estimated Cost of Attrition
-- Business Question: What is the financial impact of attrition?
-- Logic: High-risk agents x estimated replacement cost
-- ============================================================
WITH risk_agents AS (
    SELECT
        a.agent_id,
        CASE
            WHEN AVG(c.csat_score) < 2.0
                 AND AVG(c.handle_time_sec) > 400
            THEN 1
            ELSE 0
        END AS is_high_risk
    FROM agents a
    JOIN calls c ON a.agent_id = c.agent_id
    GROUP BY a.agent_id
)
SELECT
    SUM(is_high_risk) AS high_risk_agents,
    SUM(is_high_risk) * 5000 AS estimated_attrition_cost_usd
FROM risk_agents;

-- Note: $5,000 estimated replacement cost per agent
-- (recruitment + training + productivity loss)
-- 5 high-risk agents x $5,000 = $25,000 estimated cost
