-- create new database ------
create database project2_new_data;
-- -------------------------------------------------------------------------------------------------------
use project2_new_data ;
-- ------------------------------------------------------------------------------------------------
-- create Table--

CREATE TABLE cards (
    Batch_ID VARCHAR(20) NULL,
    Job_Order_Number VARCHAR(20) ,
    Printing_Date_Time DATE ,
    Printer_Operator_ID VARCHAR(20) ,
    Ink_Type VARCHAR(50) ,
    Paper_Type VARCHAR(50) ,
    No_of_Sheets_Used INT ,
    No_of_cards_Printed INT ,
    No_of_Half_cards INT ,
    No_of_Quarter_cards INT null ,
    Accepted_cards INT ,
    Rejected_cards INT ,
    Color_Matching_Data VARCHAR(20) ,
    Quality_Control_Result_Printing VARCHAR(10) ,
    Printing_QC_Alignment VARCHAR(10) ,
    Printing_QC_Color_Accuracy VARCHAR(10) ,
    Printing_QC_Material_Integrity VARCHAR(10) ,
    Lamination_Date_Time DATETIME ,
    Lamination_Operator_ID VARCHAR(20) ,
    Chip_Type VARCHAR(20) ,
    Embedding_Errors INT ,
    Chip_Serial_Numbers VARCHAR(20) ,
    Quality_Control_Result_Embedding VARCHAR(10) ,
    Embedding_QC_Chip_Functionality VARCHAR(10) ,
    Embedding_QC_Alignment VARCHAR(10) ,
    Network_Data VARCHAR(50) ,
    Encryption_Key VARCHAR(50) ,
    Laser_Engraving_Serial VARCHAR(20) ,
    ICCID VARCHAR(20) ,
    Personalization_Operator_ID VARCHAR(20) ,
    Quality_Control_Result_Personalization VARCHAR(10) ,
    Personalization_QC_Data_Accuracy VARCHAR(10) ,
    Personalization_QC_Laser_Engraving VARCHAR(10) ,
    Audit_Trail_Logs VARCHAR(20) ,
    PO_number VARCHAR(20) 
);
describe cards;

ALTER TABLE cards 
modify Accepted_cards VARCHAR(255);

ALTER TABLE cards 
modify Rejected_cards VARCHAR(255);

ALTER TABLE cards 
modify Printing_Date_Time date;

-- LOAD DATA-----------------------
LOAD DATA INFILE "D:\project_2_data.csv"  
INTO TABLE cards  
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\r\n'  
IGNORE 1 LINES  
(Batch_ID, Job_Order_Number, @Printing_Date_Time, Printer_Operator_ID, Ink_Type, Paper_Type, @No_of_Sheets_Used, No_of_cards_Printed, No_of_Half_cards, @No_of_Quarter_cards, Accepted_cards, Rejected_cards, Color_Matching_Data, Quality_Control_Result_Printing, Printing_QC_Alignment, Printing_QC_Color_Accuracy, Printing_QC_Material_Integrity, @Lamination_Date_Time, Lamination_Operator_ID, Chip_Type, Embedding_Errors, Chip_Serial_Numbers, Quality_Control_Result_Embedding, Embedding_QC_Chip_Functionality, Embedding_QC_Alignment, Network_Data, Encryption_Key, Laser_Engraving_Serial, ICCID, Personalization_Operator_ID, Quality_Control_Result_Personalization, Personalization_QC_Data_Accuracy, Personalization_QC_Laser_Engraving, Audit_Trail_Logs, PO_number)  
SET 
    Printing_Date_Time = CASE WHEN @Printing_Date_Time = '' THEN NULL ELSE STR_TO_DATE(@Printing_Date_Time, '%Y-%m-%d %H:%i:%s') END,
    No_of_Sheets_Used = CASE WHEN @No_of_Sheets_Used = '' THEN NULL ELSE @No_of_Sheets_Used END,
    No_of_cards_Printed = CASE WHEN No_of_cards_Printed = '' THEN NULL ELSE No_of_cards_Printed END,
    No_of_Half_cards = CASE WHEN No_of_Half_cards = '' THEN NULL ELSE No_of_Half_cards END,
    No_of_Quarter_cards = CASE WHEN @No_of_Quarter_cards = '' THEN NULL ELSE @No_of_Quarter_cards END,
    Lamination_Date_Time = CASE WHEN @Lamination_Date_Time = '' THEN NULL ELSE STR_TO_DATE(@Lamination_Date_Time, '%Y-%m-%d %H:%i:%s') END;


-- ----------------------------------------------------------------------------------------------------------------------------


select * from cards;
SELECT count(*) FROM cards;
-- ----------------------------------------------------------------------------------------------------------

--  FIRST EDA BUSSINESS MOMEMTS 

-- MEAN
select
 
 avg(Embedding_Errors) as mean_Embedding_Errors,
 avg(No_of_Sheets_Used) as mean_No_of_Sheets_Used,
 avg(No_of_cards_Printed) as mean_No_of_cards_Printed,
 avg(No_of_Half_cards) as mean_No_of_Half_cards,
 avg(No_of_Quarter_cards) as mean_No_of_Quarter_cards,
 avg(Accepted_cards) as mean_Accepted_cards,
 avg(Rejected_cards) as mean_Rejected_cards
from cards;

-------------------------------------------------------------------------------------------------------------------

-- MEDIAN 

SELECT
      (SELECT AVG(sub.Embedding_Errors) AS Embedding_Errors_Median
FROM (
    SELECT 
        `Embedding_Errors` AS Embedding_Errors,
        ROW_NUMBER() OVER (ORDER BY `Embedding_Errors`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS Embedding_Errors_Median,

	

(SELECT AVG(sub.No_of_Sheets_Used) AS No_of_Sheets_Used_Median
FROM (
    SELECT 
        `No_of_Sheets_Used` AS No_of_Sheets_Used,
        ROW_NUMBER() OVER (ORDER BY `No_of_Sheets_Used`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS No_of_Sheets_Used_Median,

(SELECT AVG(sub.No_of_cards_Printed) AS No_of_cards_Printed_Median
FROM (
    SELECT 
        `No_of_cards_Printed` AS No_of_cards_Printed,
        ROW_NUMBER() OVER (ORDER BY `No_of_cards_Printed`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS No_of_cards_Printed_Median,

(SELECT AVG(sub.No_of_Half_cards) AS No_of_Half_cards_Median
FROM (
    SELECT 
        `No_of_Half_cards` AS No_of_Half_cards,
        ROW_NUMBER() OVER (ORDER BY `No_of_Half_cards`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS No_of_Half_cards_Median,

(SELECT AVG(sub.No_of_Quarter_cards) AS No_of_Quarter_cards_Median
FROM (
    SELECT 
        `No_of_Quarter_cards` AS No_of_Quarter_cards,
        ROW_NUMBER() OVER (ORDER BY `No_of_Quarter_cards`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS No_of_Quarter_cards_Median,

(SELECT AVG(sub.Accepted_cards) AS Accepted_cards_Median
FROM (
    SELECT 
        `Accepted_cards` AS Accepted_cards,
        ROW_NUMBER() OVER (ORDER BY `Accepted_cards`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS Accepted_cards_Median,

(SELECT AVG(sub.Rejected_cards) AS Rejected_cards_Median
FROM (
    SELECT 
        `Rejected_cards` AS Rejected_cards,
        ROW_NUMBER() OVER (ORDER BY `Rejected_cards`) AS rn,
        COUNT(*) OVER () AS cnt
    FROM cards
) sub
WHERE sub.rn IN (FLOOR((sub.cnt + 1) / 2), CEIL((sub.cnt + 1) / 2))
) AS Rejected_cards_Median ;


-- ---------------------------------------------------------------------------------------------------------------
-- MODE

-- Initialize variables for mode calculation
SET @row_number := 0;
SET @total_count := (SELECT COUNT(*) FROM cards);

-- Mode calculation for multiple columns
SELECT
    -- Mode of Embedding Errors
    (SELECT mode_value
     FROM (
         SELECT 
             `Embedding_Errors` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `Embedding_Errors` IS NOT NULL
         GROUP BY `Embedding_Errors`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS Embedding_Errors_Mode,

    

    -- Mode of No. of Sheets Used
    (SELECT mode_value
     FROM (
         SELECT 
             `No_of_Sheets_Used` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `No_of_Sheets_Used` IS NOT NULL
         GROUP BY `No_of_Sheets_Used`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS No_of_Sheets_Used_Mode,

    -- Mode of No. of cards Printed
    (SELECT mode_value
     FROM (
         SELECT 
             `No_of_cards_Printed` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `No_of_cards_Printed` IS NOT NULL
         GROUP BY `No_of_cards_Printed`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS No_of_cards_Printed_Mode,

    -- Mode of No. of Half cards
    (SELECT mode_value
     FROM (
         SELECT 
             `No_of_Half_cards` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `No_of_Half_cards` IS NOT NULL
         GROUP BY `No_of_Half_cards`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS No_of_Half_cards_Mode,

    -- Mode of No. of Quarter cards
    (SELECT mode_value
     FROM (
         SELECT 
             `No_of_Quarter_Cards` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `No_of_Quarter_Cards` IS NOT NULL
         GROUP BY `No_of_Quarter_Cards`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS No_of_Quarter_Cards_Mode,

    -- Mode of Accepted Cards
    (SELECT mode_value
     FROM (
         SELECT 
             `Accepted_Cards` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `Accepted_Cards` IS NOT NULL
         GROUP BY `Accepted_Cards`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS Accepted_Cards_Mode,

    -- Mode of Rejected Cards
    (SELECT mode_value
     FROM (
         SELECT 
             `Rejected_Cards` AS mode_value,
             COUNT(*) AS occurrence
         FROM cards
         WHERE `Rejected_Cards` IS NOT NULL
         GROUP BY `Rejected_Cards`
         ORDER BY occurrence DESC
         LIMIT 1
     ) AS mode_subquery
    ) AS Rejected_Cards_Mode;



-- -------------------------------------------------------------------------------------------------------------------
-- second bussiness momemts 
-- std dev

select
 stddev(Embedding_Errors) as stddev_Embedding_Errors,
 stddev(No_of_Sheets_Used) as stddev_No_of_Sheets_Used,
 stddev(No_of_Cards_Printed) as stddev_No_of_Cards_Printed,
 stddev(No_of_Half_Cards) as stddev_No_of_Half_Cards,
 stddev(No_of_Quarter_Cards) as stddev_No_of_Quarter_Cards,
 stddev(Accepted_Cards) as stddev_Accepted_Cards,
 stddev(Rejected_Cards) as stddev_Rejected_Cards
from cardS;

-- -------------------------------------------------------------------------------------------------------------
-- Variance

select
 
 variance(Embedding_Errors) as variance_Embedding_Errors,
 variance(No_of_Sheets_Used) as variance_No_of_Sheets_Used,
 variance(No_of_Cards_Printed) as variance_No_of_Cards_Printed,
 variance(No_of_Half_Cards) as variance_No_of_Half_Cards,
 variance(No_of_Quarter_Cards) as variance_No_of_Quarter_Cards,
 variance(Accepted_Cards) as variance_Accepted_Cards,
 variance(Chip_Type) as variance_Chip_Type,
 variance(Rejected_Cards) as variance_Rejected_Cards
from cards;

-- --------------------------------------------------------------------------------------------------------------

-- RANGE


SELECT
    -- Range for Embedding Errors
    MAX(CAST(`Embedding_Errors` AS DECIMAL)) - MIN(CAST(`Embedding_Errors` AS DECIMAL)) AS range_embedding_errors,

    -
    -- Range for No. of Sheets Used
    MAX(CAST(`No_of_Sheets_Used` AS DECIMAL)) - MIN(CAST(`No_of_Sheets_Used` AS DECIMAL)) AS range_no_of_sheets_used,

    -- Range for No. of Cards Printed
    MAX(CAST(`No_of_Cards_Printed` AS DECIMAL)) - MIN(CAST(`No_of_Cards_Printed` AS DECIMAL)) AS range_no_of_cards_printed,

    -- Range for No. of Half Cards
    MAX(CAST(`No_of_Half_Cards` AS DECIMAL)) - MIN(CAST(`No_of_Half_Cards` AS DECIMAL)) AS range_no_of_half_cards,

    -- Range for No. of Quarter Cards
    MAX(CAST(`No_of_Quarter_Cards` AS DECIMAL)) - MIN(CAST(`No_of_Quarter_Cards` AS DECIMAL)) AS range_no_of_quarter_cards,

    -- Range for Accepted Cards
    MAX(CAST(`Accepted_Cards` AS DECIMAL)) - MIN(CAST(`Accepted_Cards` AS DECIMAL)) AS range_accepted_cards,

    -- Range for Rejected Cards
    MAX(CAST(`Rejected_Cards` AS DECIMAL)) - MIN(CAST(`Rejected_Cards` AS DECIMAL)) AS range_rejected_cards

FROM cards;


-- -----------------------------------------------------------------------------------------------------
-- THIRD BUSSINESS MOMENTS 
-- SKEWNESS 

SELECT
    -- Skewness for Embedding Errors
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`Embedding_Errors` AS DECIMAL) - 
    (SELECT AVG(CAST(`Embedding_Errors` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Embedding_Errors` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_embedding_errors,

   

    -- Skewness for No. of Sheets Used
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`No_of_Sheets_Used` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Sheets_Used` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Sheets_Used` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_no_of_sheets_used,

    -- Skewness for No. of Cards Printed
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`No_of_Cards_Printed` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Cards_Printed` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Cards_Printed` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_no_of_cards_printed,

    -- Skewness for No. of Half Cards
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`No_of_Half_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Half_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Half_Cards` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_no_of_half_cards,

    -- Skewness for No. of Quarter Cards
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`No_of_Quarter_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Quarter_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Quarter_Cards` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_no_of_quarter_cards,

    -- Skewness for Accepted Cards
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`Accepted_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`Accepted_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Accepted_Cards` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_accepted_cards,

    -- Skewness for Rejected Cards
    (COUNT(*) / (COUNT(*) - 1) / (COUNT(*) - 2)) * 
    SUM(POW((CAST(`Rejected_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`Rejected_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Rejected_Cards` AS DECIMAL)) FROM cards), 3)) 
    AS skewness_rejected_cards

FROM cards;

-- --------------------------------------------------------------------------------------------------------
-- FOURTH BUSSINESS MOMENTS
-- KURTOSIS

SELECT
    -- Kurtosis for Embedding Errors
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`Embedding_Errors` AS DECIMAL) - 
    (SELECT AVG(CAST(`Embedding_Errors` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Embedding_Errors` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_embedding_errors,

     

    -- Kurtosis for No. of Sheets Used
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`No_of_Sheets_Used` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Sheets_Used` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Sheets_Used` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_no_of_sheets_used,

    -- Kurtosis for No. of Cards Printed
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`No_of_Cards_Printed` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Cards_Printed` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Cards_Printed` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_no_of_cards_printed,

    -- Kurtosis for No. of Half Cards
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`No_of_Half_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Half_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Half_Cards` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_no_of_half_cards,

    -- Kurtosis for No. of Quarter Cards
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`No_of_Quarter_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`No_of_Quarter_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`No_of_Quarter_Cards` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_no_of_quarter_cards,

    -- Kurtosis for Accepted Cards
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`Accepted_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`Accepted_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Accepted_Cards` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_accepted_cards,

    -- Kurtosis for Rejected Cards
    ((COUNT(*) * (COUNT(*) + 1)) / ((COUNT(*) - 1) * (COUNT(*) - 2) * (COUNT(*) - 3))) * 
    SUM(POW((CAST(`Rejected_Cards` AS DECIMAL) - 
    (SELECT AVG(CAST(`Rejected_Cards` AS DECIMAL)) FROM cards)) / 
    (SELECT STDDEV(CAST(`Rejected_Cards` AS DECIMAL)) FROM cards), 4)) -
    (3 * POW((COUNT(*) - 1), 2)) / ((COUNT(*) - 2) * (COUNT(*) - 3))
    AS kurtosis_rejected_cards

FROM cards;

-- ----------------------------------------------------------------------------------------------------------------------------------

-- DATA PREPROCCESSING----------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------
-- TYPECASTING -----------------------------------------------------------------------------------------------------------
SELECT
    CAST(`Batch_ID` AS CHAR) AS Batch_ID ,
    CAST(`Job_Order_Number` AS CHAR) AS Job_Order_Number,
    CAST(`Printing_Date_Time` AS DATE) AS Printing_Date ,
    CAST(`Printer_Operator_ID` AS CHAR) AS Printer_Operator_ID,
    CAST(`Ink_Type` AS CHAR) AS Ink_Type,
    CAST(`Paper_Type` AS CHAR) AS Paper_Type ,
    CAST(`Color_Matching_Data` AS char) AS Color_Matching_Data , 
    CAST(`Quality_Control_Result_Printing` AS char) AS Quality_Control_Results_Printing ,
    CAST(`Lamination_Date_Time` AS DATETIME) AS Lamination_Date_Time,
    CAST(`Lamination_Operator_ID` AS CHAR) AS Lamination_Operator_ID,
    CAST(`Chip_Type` AS CHAR) AS Chip_Type,
    CAST(`Embedding_Errors` AS DECIMAL(10, 2)) AS Embedding_Errors,
    CAST(`Chip_Serial_Numbers` AS CHAR) AS Chip_Serial_Numbers,
    CAST(`Quality_Control_Result_Embedding` AS CHAR) AS Quality_Control_Results_Embedding,
    CAST(`Network_Data` AS CHAR) AS Network_Data,
    CAST(`Encryption_Key` AS CHAR) AS Encryption_Key,
    CAST(`Laser_Engraving_Serial` AS CHAR) AS Laser_Engraving_Serial,
    CAST(`ICCID` AS CHAR) AS ICCID,
    CAST(`Personalization_Operator_ID` AS CHAR) AS Personalization_Operator_ID,
    CAST(`Quality_Control_Result_Personalization` AS CHAR) AS Quality_Control_Results_Personalization,
    CAST(`Audit_Trail_Logs` AS CHAR) AS Audit_Trail_Logs,
    CAST(`Printing_QC` AS CHAR) AS Printing_QC,
    CAST(`Printing_QC_Color_Accuracy` AS DECIMAL(5, 2)) AS Printing_QC_Color_Accuracy,
    CAST(`Printing_QC_Material_Integrity` AS DECIMAL(5, 2)) AS Printing_QC_Material_Integrity,
    CAST(`Embedding_QC_Chip_Functionality` AS DECIMAL(5, 2)) AS Embedding_QC_Chip_Functionality,
    CAST(`Embedding_QC_Alignment` AS DECIMAL(5, 2)) AS Embedding_QC_Alignment,
    CAST(`Personalization_QC_Data_Accuracy` AS DECIMAL(5, 2)) AS Personalization_QC_Data_Accuracy,
    CAST(`Personalization_QC_Laser_Engraving` AS DECIMAL(5, 2)) AS Personalization_QC_Laser_Engraving,
    CAST(`No_of_Sheets_Used` AS REAL) AS No_of_Sheets_Used,
    CAST(`No_of_Cards_Printed` AS REAL) AS No_of_Cards_Printed,
    CAST(`No_of_Half_Cards` AS REAL) AS No_of_Half_Cards,
    CAST(`No_of_Quarter_Cards` AS REAL) AS No_of_Quarter_Cards,
    CAST(`Accepted_Cards` AS REAL) AS Accepted_Cards,
    CAST(`Rejected_Cards` AS REAL) AS Rejected_Cards
FROM cards;
-- -------------------------------------------------------------------------------------------------------------------
select count(*) FROM CARDS;
-- ------------------------------------------------------------------------------------------------------------------------------------------
WITH DuplicateRecords AS (
    SELECT
        Batch_ID,
        ROW_NUMBER() OVER (
            PARTITION BY
                embedding_errors,
                no_of_sheets_used,
                no_of_cards_printed,
                no_of_half_cards,
                no_of_quarter_cards,
                accepted_cards,
                rejected_cards
            ORDER BY Batch_ID
        ) AS row_num
    FROM Cards
)
SELECT *
FROM DuplicateRecords
WHERE row_num > 1;
-- ------------------------------------------------------------------------------------------------------------------------------

-- Drop duplicates
DELETE FROM cards
WHERE (embedding_errors, 
       no_of_sheets_used, no_of_cards_printed, no_of_half_cards, 
       no_of_quarter_cards, accepted_cards, rejected_cards) IN (
    SELECT embedding_errors,
           no_of_sheets_used, no_of_cards_printed, no_of_half_cards, 
           no_of_quarter_cards, accepted_cards, rejected_cards
    FROM (
        SELECT embedding_errors,  
               no_of_sheets_used, no_of_cards_printed, no_of_half_cards, 
               no_of_quarter_cards, accepted_cards, rejected_cards,
               ROW_NUMBER() OVER (
                   PARTITION BY embedding_errors, 
                                   no_of_sheets_used, 
                                  no_of_cards_printed, no_of_half_cards, 
                                  no_of_quarter_cards, accepted_cards, rejected_cards
                   ORDER BY (SELECT NULL)
               ) AS rn
        FROM cards
    ) AS subquery
    WHERE rn > 1
);


select * from cards;
-- ------------------------------------------------------------------------------------------------------------------
select count(*) from cards;
-- ----------------------------------------------------------------------------------------------------------------------------

-- OUTLIERS 
-- -------------------------------------

  SET SQL_SAFE_UPDATES = 0; 
  select * from cards;
    
-- Update Embedding_Errors column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `Embedding_Errors`,
        NTILE(4) OVER (ORDER BY `Embedding_Errors`) AS `Embedding_Errors_quartile`
    FROM CARDS
) AS subquery
ON e.`Embedding_Errors` = subquery.`Embedding_Errors`
SET e.`Embedding_Errors` = (
    SELECT AVG(`Embedding_Errors`)
    FROM (
        SELECT
            `Embedding_Errors`,
            NTILE(4) OVER (ORDER BY `Embedding_Errors`) AS `Embedding_Errors_quartile`
        FROM CARDS
    ) AS temp
    WHERE `Embedding_Errors_quartile` = subquery.`Embedding_Errors_quartile`
)
WHERE subquery.`Embedding_Errors_quartile` IN (1, 4);



-- Update No_of_Sheets_Used column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `No_of_Sheets_Used`,
        NTILE(4) OVER (ORDER BY `No_of_Sheets_Used`) AS `No_of_Sheets_Used_quartile`
    FROM CARDS
) AS subquery
ON e.`No_of_Sheets_Used` = subquery.`No_of_Sheets_Used`
SET e.`No_of_Sheets_Used` = (
    SELECT AVG(`No_of_Sheets_Used`)
    FROM (
        SELECT
            `No_of_Sheets_Used`,
            NTILE(4) OVER (ORDER BY `No_of_Sheets_Used`) AS `No_of_Sheets_Used_quartile`
        FROM CARDS
    ) AS temp
    WHERE `No_of_Sheets_Used_quartile` = subquery.`No_of_Sheets_Used_quartile`
)
WHERE subquery.`No_of_Sheets_Used_quartile` IN (1, 4);

-- Update No_of_Cards_Printed column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `No_of_Cards_Printed`,
        NTILE(4) OVER (ORDER BY `No_of_Cards_Printed`) AS `No_of_Cards_Printed_quartile`
    FROM CARDS
) AS subquery
ON e.`No_of_Cards_Printed` = subquery.`No_of_Cards_Printed`
SET e.`No_of_Cards_Printed` = (
    SELECT AVG(`No_of_Cards_Printed`)
    FROM (
        SELECT
            `No_of_Cards_Printed`,
            NTILE(4) OVER (ORDER BY `No_of_Cards_Printed`) AS `No_of_Cards_Printed_quartile`
        FROM CARDS
    ) AS temp
    WHERE `No_of_Cards_Printed_quartile` = subquery.`No_of_Cards_Printed_quartile`
)
WHERE subquery.`No_of_Cards_Printed_quartile` IN (1, 4);

-- Update No_of_Half_Cards column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `No_of_Half_Cards`,
        NTILE(4) OVER (ORDER BY `No_of_Half_Cards`) AS `No_of_Half_Cards_quartile`
    FROM CARDS
) AS subquery
ON e.`No_of_Half_Cards` = subquery.`No_of_Half_Cards`
SET e.`No_of_Half_Cards` = (
    SELECT AVG(`No_of_Half_Cards`)
    FROM (
        SELECT
            `No_of_Half_Cards`,
            NTILE(4) OVER (ORDER BY `No_of_Half_Cards`) AS `No_of_Half_Cards_quartile`
        FROM CARDS
    ) AS temp
    WHERE `No_of_Half_Cards_quartile` = subquery.`No_of_Half_Cards_quartile`
)
WHERE subquery.`No_of_Half_Cards_quartile` IN (1, 4);

-- Update No_of_Quarter_Cards column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `No_of_Quarter_Cards`,
        NTILE(4) OVER (ORDER BY `No_of_Quarter_Cards`) AS `No_of_Quarter_Cards_quartile`
    FROM CARDS
) AS subquery
ON e.`No_of_Quarter_Cards` = subquery.`No_of_Quarter_Cards`
SET e.`No_of_Quarter_Cards` = (
    SELECT AVG(`No_of_Quarter_Cards`)
    FROM (
        SELECT
            `No_of_Quarter_Cards`,
            NTILE(4) OVER (ORDER BY `No_of_Quarter_Cards`) AS `No_of_Quarter_Cards_quartile`
        FROM CARDS
    ) AS temp
    WHERE `No_of_Quarter_Cards_quartile` = subquery.`No_of_Quarter_Cards_quartile`
)
WHERE subquery.`No_of_Quarter_Cards_quartile` IN (1, 4);

-- Update Accepted_Cards column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `Accepted_Cards`,
        NTILE(4) OVER (ORDER BY `Accepted_Cards`) AS `Accepted_Cards_quartile`
    FROM CARDS
) AS subquery
ON e.`Accepted_Cards` = subquery.`Accepted_Cards`
SET e.`Accepted_Cards` = (
    SELECT AVG(`Accepted_Cards`)
    FROM (
        SELECT
            `Accepted_Cards`,
            NTILE(4) OVER (ORDER BY `Accepted_Cards`) AS `Accepted_Cards_quartile`
        FROM CARDS
    ) AS temp
    WHERE `Accepted_Cards_quartile` = subquery.`Accepted_Cards_quartile`
)
WHERE subquery.`Accepted_Cards_quartile` IN (1, 4);

-- Update Rejected_Cards column based on quartile values
UPDATE CARDS AS e
JOIN (
    SELECT
        `Rejected_Cards`,
        NTILE(4) OVER (ORDER BY `Rejected_Cards`) AS `Rejected_Cards_quartile`
    FROM CARDS
) AS subquery
ON e.`Rejected_Cards` = subquery.`Rejected_Cards`
SET e.`Rejected_Cards` = (
    SELECT AVG(`Rejected_Cards`)
    FROM (
        SELECT
            `Rejected_Cards`,
            NTILE(4) OVER (ORDER BY `Rejected_Cards`) AS `Rejected_Cards_quartile`
        FROM CARDS
    ) AS temp
    WHERE `Rejected_Cards_quartile` = subquery.`Rejected_Cards_quartile`
)
WHERE subquery.`Rejected_Cards_quartile` IN (1, 4);

SELECT * from cards ;
--    ----------------
-- MISSING values

-- Replace NULL values in numeric columns with the column's mean
UPDATE cards
JOIN (
    SELECT 
        AVG(CAST(No_of_Sheets_Used AS DECIMAL(10, 2))) AS avg_No_of_Sheets_Used,
        AVG(CAST(No_of_cards_Printed AS DECIMAL(10, 2))) AS avg_No_of_cards_Printed,
        AVG(CAST(No_of_Half_cards AS DECIMAL(10, 2))) AS avg_No_of_Half_cards,
        AVG(CAST(No_of_Quarter_cards AS DECIMAL(10, 2))) AS avg_No_of_Quarter_cards,
        AVG(CAST(Accepted_cards AS DECIMAL(10, 2))) AS avg_Accepted_cards,
        AVG(CAST(Rejected_cards AS DECIMAL(10, 2))) AS avg_Rejected_cards,
        AVG(CAST(Embedding_Errors AS DECIMAL(10, 2))) AS avg_Embedding_Errors
    FROM cards
    WHERE 
        No_of_Sheets_Used REGEXP '^[0-9.]+$' AND
        No_of_cards_Printed REGEXP '^[0-9.]+$' AND
        No_of_Half_cards REGEXP '^[0-9.]+$' AND
        No_of_Quarter_cards REGEXP '^[0-9.]+$' AND
        Accepted_cards REGEXP '^[0-9.]+$' AND
        Rejected_cards REGEXP '^[0-9.]+$' AND
        Embedding_Errors REGEXP '^[0-9.]+$'
) AS averages
SET 
    No_of_Sheets_Used = COALESCE(No_of_Sheets_Used, averages.avg_No_of_Sheets_Used),
    No_of_cards_Printed = COALESCE(No_of_cards_Printed, averages.avg_No_of_cards_Printed),
    No_of_Half_cards = COALESCE(No_of_Half_cards, averages.avg_No_of_Half_cards),
    No_of_Quarter_cards = COALESCE(No_of_Quarter_cards, averages.avg_No_of_Quarter_cards),
    Accepted_cards = COALESCE(Accepted_cards, averages.avg_Accepted_cards),
    Rejected_cards = COALESCE(Rejected_cards, averages.avg_Rejected_cards),
    Embedding_Errors = COALESCE(Embedding_Errors, averages.avg_Embedding_Errors)
WHERE 
    No_of_Sheets_Used IS NULL OR
    No_of_cards_Printed IS NULL OR
    No_of_Half_cards IS NULL OR
    No_of_Quarter_cards IS NULL OR
    Accepted_cards IS NULL OR
    Rejected_cards IS NULL OR
    Embedding_Errors IS NULL;

-- Replace NULL values in numeric columns with the column's mean
UPDATE cards
SET 
    No_of_Sheets_Used = COALESCE(No_of_Sheets_Used, (SELECT AVG(No_of_Sheets_Used) FROM cards)),
    No_of_cards_Printed = COALESCE(No_of_cards_Printed, (SELECT AVG(No_of_cards_Printed) FROM cards)),
    No_of_Half_cards = COALESCE(No_of_Half_cards, (SELECT AVG(No_of_Half_cards) FROM cards)),
    No_of_Quarter_cards = COALESCE(No_of_Quarter_cards, (SELECT AVG(No_of_Quarter_cards) FROM cards)),
    Accepted_cards = COALESCE(Accepted_cards, (SELECT AVG(Accepted_cards) FROM cards)),
    Rejected_cards = COALESCE(Rejected_cards, (SELECT AVG(Rejected_cards) FROM cards)),
    Embedding_Errors = COALESCE(Embedding_Errors, (SELECT AVG(Embedding_Errors) FROM cards))
WHERE 
    No_of_Sheets_Used IS NULL OR
    No_of_cards_Printed IS NULL OR
    No_of_Half_cards IS NULL OR
    No_of_Quarter_cards IS NULL OR
    Accepted_cards IS NULL OR
    Rejected_cards IS NULL OR
    Embedding_Errors IS NULL;

select * from cards;

UPDATE cards
JOIN (
    SELECT 
        AVG(CAST(No_of_Sheets_Used AS DECIMAL(10, 2))) AS avg_No_of_Sheets_Used,
        AVG(CAST(No_of_cards_Printed AS DECIMAL(10, 2))) AS avg_No_of_cards_Printed,
        AVG(CAST(No_of_Half_cards AS DECIMAL(10, 2))) AS avg_No_of_Half_cards,
        AVG(CAST(No_of_Quarter_cards AS DECIMAL(10, 2))) AS avg_No_of_Quarter_cards,
        AVG(CAST(Accepted_cards AS DECIMAL(10, 2))) AS avg_Accepted_cards,
        AVG(CAST(Rejected_cards AS DECIMAL(10, 2))) AS avg_Rejected_cards,
        AVG(CAST(Embedding_Errors AS DECIMAL(10, 2))) AS avg_Embedding_Errors
    FROM cards
    WHERE 
        No_of_Sheets_Used REGEXP '^[0-9.]+$' AND
        No_of_cards_Printed REGEXP '^[0-9.]+$' AND
        No_of_Half_cards REGEXP '^[0-9.]+$' AND
        No_of_Quarter_cards REGEXP '^[0-9.]+$' AND
        Accepted_cards REGEXP '^[0-9.]+$' AND
        Rejected_cards REGEXP '^[0-9.]+$' AND
        Embedding_Errors REGEXP '^[0-9.]+$'
) AS averages
SET 
    No_of_Sheets_Used = COALESCE(No_of_Sheets_Used, averages.avg_No_of_Sheets_Used),
    No_of_cards_Printed = COALESCE(No_of_cards_Printed, averages.avg_No_of_cards_Printed),
    No_of_Half_cards = COALESCE(No_of_Half_cards, averages.avg_No_of_Half_cards),
    No_of_Quarter_cards = COALESCE(No_of_Quarter_cards, averages.avg_No_of_Quarter_cards),
    Accepted_cards = COALESCE(Accepted_cards, averages.avg_Accepted_cards),
    Rejected_cards = COALESCE(Rejected_cards, averages.avg_Rejected_cards),
    Embedding_Errors = COALESCE(Embedding_Errors, averages.avg_Embedding_Errors)
WHERE 
    No_of_Sheets_Used IS NULL OR
    No_of_cards_Printed IS NULL OR
    No_of_Half_cards IS NULL OR
    No_of_Quarter_cards IS NULL OR
    Accepted_cards IS NULL OR
    Rejected_cards IS NULL OR
    Embedding_Errors IS NULL;
    
select * from cards ;

