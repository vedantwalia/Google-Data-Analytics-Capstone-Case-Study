-- Dropping the table incase it already exists to avoid errors

DROP TABLE IF EXISTS `capstone_raw_data.combined-data`;

-- Creatig a new table that combines all the raw data we have

CREATE TABLE `capstone_raw_data.combined-data` AS (
SELECT * FROM`capstone_raw_data.202308-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202309-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202310-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202311-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202312-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202401-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202402-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202403-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202404-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202405-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202406-divvy-tripdata`
UNION ALL
SELECT * FROM`capstone_raw_data.202407-divvy-tripdata`
);

-- Counting the number of rows we have in our new table

SELECT count(*)
FROM `capstone_raw_data.combined-data`;

-- There are 5715693 rows in this table