-- Checking data types of all columns

SELECT column_name, data_type
FROM `capstone_raw_data`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'combined-data';

-- Checking for NULLs in all columns

SELECT COUNT(*) - COUNT(ride_id) AS null_ride_id,
 COUNT(*) - COUNT(rideable_type) AS null_rideable_type,
 COUNT(*) - COUNT(started_at) AS null_started_at,
 COUNT(*) - COUNT(ended_at) AS null_ended_at,
 COUNT(*) - COUNT(start_station_name) AS null_start_station_name,
 COUNT(*) - COUNT(start_station_id) AS null_start_station_id,
 COUNT(*) - COUNT(end_station_name) AS null_end_station_name,
 COUNT(*) - COUNT(end_station_id) AS null_end_station_id,
 COUNT(*) - COUNT(start_lat) AS null_start_lat,
 COUNT(*) - COUNT(start_lng) AS null_start_lng,
 COUNT(*) - COUNT(end_lat) AS null_end_lat,
 COUNT(*) - COUNT(end_lng) AS null_end_lng,
 COUNT(*) - COUNT(member_casual) AS null_member_casual
FROM `capstone_raw_data.combined-data`;

-- In null_start_station_name and null_start_station_id, 947025 entries are NULL
-- In null_end_station_name and null_end_station_id, 989476 entries are NULL
-- in null_end_lat and null_end_lng, 7756 entries are NULL

-- Checking ride_id for duplicate rows 

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) as Duplicates
FROM `capstone_raw_data.combined-data`;  -- There are 211 duplicate entries


-- Verifying that all ride_id are uniformly 16 character long

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM `capstone_raw_data.combined-data`
GROUP BY length_ride_id;

-- Looking at all differnet types of rides available and sorting them 

SELECT DISTINCT rideable_type, COUNT(rideable_type) AS no_of_trips
FROM `capstone_raw_data.combined-data`
GROUP BY rideable_type
ORDER BY no_of_trips DESC;

-- There are 3 types of bikes and classic_bike is the most used one

-- Focusing the time of the rides

SELECT started_at,ended_at
FROM `capstone_raw_data.combined-data`;

-- The time is returned in YYY-MM-DD HH-MM-SSSS UTC format, we can further manuplate it to check for ride length

DROP TABLE IF EXISTS `capstone_raw_data.combined-data-datetime`;

CREATE TABLE `capstone_raw_data.combined-data-datetime` AS (
SELECT 
    ride_id,
    started_at,
    ended_at,
    ROUND(TIMESTAMP_DIFF(ended_at, started_at, second)/60,1) AS ride_length,
FROM `capstone_raw_data.combined-data`);

SELECT AVG(ride_length) AS avg,
MIN(ride_length) AS min,
MAX(ride_length) AS max
FROM `capstone_raw_data.combined-data-datetime`;

-- We can see that the minimum ride is is negative and is obviously wrong, and hence should be omitted

SELECT COUNT(*) as negative_ride_length
FROM `capstone_raw_data.combined-data-datetime`
WHERE ride_length <= 0;

-- 1895 entries are negative or 0 and shall be discarded

SELECT COUNT(*) as long_ride_length
FROM `capstone_raw_data.combined-data-datetime`
WHERE ride_length > 1440;

-- 8001 rides are longer than a day

-- Now lets check for the type of members and get a count of the same

SELECT DISTINCT member_casual, COUNT(member_casual) AS no_of_trips
FROM `capstone_raw_data.combined-data`
GROUP BY member_casual;
-- member riders made 3677119 trips
-- casual riders made 2038574 trips