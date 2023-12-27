CREATE SCHEMA cyclistics;
USE cyclistics;

CREATE TABLE cyc_data
(ride_id varchar(65),
bike_type varchar(65),
started varchar(65),
ended varchar(65),
start_name varchar(65),
start_id varchar(65),
end_name varchar(65),
end_id varchar(65),
start_lat varchar(65),
start_lng varchar(65),
end_lat varchar(65),
end_lng varchar(65),
member_ varchar(65),
duration varchar(65));

-- Imported data from 2023 Jan to 2023 Mar
LOAD DATA INFILE "/Users/yanyitan/Desktop/Case Study/Cyclistic/202303_cyc.csv"
INTO TABLE cyc_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Correct the datatype
UPDATE cyc_data
SET started = DATE_FORMAT(STR_TO_DATE(started, '%d/%m/%Y %H:%i'), '%Y-%m-%d %H:%i:%s');

UPDATE cyc_data
SET ended = DATE_FORMAT(STR_TO_DATE(ended, '%d/%m/%Y %H:%i'), '%Y-%m-%d %H:%i:%s');

UPDATE cyc_data
SET duration = TIME_FORMAT(STR_TO_DATE(duration, '%H:%i:%s'), '%H:%i:%s');

-- Double check the data
SELECT * FROM cyc_data;

-- Export with headers
SELECT 'ride_id', 'bike_type', 'started', 'ended', 'start_name', 'start_id', 'end_name', 'end_id', 'start_lat', 'start_lng', 'end_lat', 'end_lng', 'member_', 'duration'
UNION
SELECT ride_id, bike_type, started, ended, start_name, start_id, end_name, end_id, start_lat, start_lng, end_lat, end_lng, member_, duration
FROM cyc_data
INTO OUTFILE '/Users/yanyitan/Desktop/Case Study/Cyclistic/2023Q1cyc_data.csv'
FIELDS TERMINATED BY ',';



