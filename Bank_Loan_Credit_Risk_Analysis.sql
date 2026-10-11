USE BankLoanAnalysis;
GO

/* =========================================================
   1. DATA CLEANING
   Convert incorrect purpose value 'caro' to 'car'
   ========================================================= */

UPDATE dbo.credit_risk
SET purpose = 'car'
WHERE purpose = 'caro';


/* =========================================================
   2. OVERALL DATASET SUMMARY
   Shows the total number of loan records
   ========================================================= */

SELECT
    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [default] = 1 THEN 1
        ELSE 0
    END) AS Defaulted_Loans,

    SUM(CASE
        WHEN [default] = 0 THEN 1
        ELSE 0
    END) AS Non_Defaulted_Loans,

    CAST(
        SUM(CASE
            WHEN [default] = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate_Percent

FROM dbo.credit_risk;


/* =========================================================
   3. DEFAULT VS NON-DEFAULT
   Shows how many total loans are defaulted/non-defaulted
   ========================================================= */

SELECT
    [default],

    COUNT(*) AS Total_Loans

FROM dbo.credit_risk

GROUP BY [default]

ORDER BY [default];


/* =========================================================
   4. DEFAULT RATE BY CREDIT HISTORY
   ========================================================= */

SELECT
    credit_history,

    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [default] = 1 THEN 1
        ELSE 0
    END) AS Defaulted_Loans,

    SUM(CASE
        WHEN [default] = 0 THEN 1
        ELSE 0
    END) AS Non_Defaulted_Loans,

    CAST(
        SUM(CASE
            WHEN [default] = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate_Percent

FROM dbo.credit_risk

GROUP BY credit_history

ORDER BY Default_Rate_Percent DESC;


/* =========================================================
   5. DEFAULT RATE BY EMPLOYMENT DURATION
   Shows total loans for each employment category
   ========================================================= */

SELECT
    employment_duration,

    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [default] = 1 THEN 1
        ELSE 0
    END) AS Defaulted_Loans,

    SUM(CASE
        WHEN [default] = 0 THEN 1
        ELSE 0
    END) AS Non_Defaulted_Loans,

    CAST(
        SUM(CASE
            WHEN [default] = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate_Percent

FROM dbo.credit_risk

GROUP BY employment_duration

ORDER BY Default_Rate_Percent DESC;


/* =========================================================
   6. DEFAULT RATE BY LOAN PURPOSE
   Shows total loans and default rate for each purpose
   ========================================================= */

SELECT
    purpose,

    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [default] = 1 THEN 1
        ELSE 0
    END) AS Defaulted_Loans,

    SUM(CASE
        WHEN [default] = 0 THEN 1
        ELSE 0
    END) AS Non_Defaulted_Loans,

    CAST(
        SUM(CASE
            WHEN [default] = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate_Percent

FROM dbo.credit_risk

GROUP BY purpose

ORDER BY Default_Rate_Percent DESC;


/* =========================================================
   7. TOTAL LOANS BY PURPOSE
   Shows exactly how many loans belong to each purpose
   ========================================================= */

SELECT
    purpose,

    COUNT(*) AS Total_Loans

FROM dbo.credit_risk

GROUP BY purpose

ORDER BY Total_Loans DESC;


/* =========================================================
   8. DATA CLEANING VERIFICATION
   Should return ZERO rows.
   Confirms 'caro' no longer exists.
   ========================================================= */

SELECT
    purpose,
    COUNT(*) AS Total_Loans

FROM dbo.credit_risk

WHERE purpose IN ('caro', 'caro0')

GROUP BY purpose;


/* =========================================================
   9. FINAL TOTAL RECORD CHECK
   Confirms the dataset contains 1000 loan records
   ========================================================= */

SELECT
    COUNT(*) AS Total_Loans
FROM dbo.credit_risk;
GO