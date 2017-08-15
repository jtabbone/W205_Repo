CREATE EXTERNAL TABLE HOSPITAL_COMPARE.measures (
Measure_Name string,
Measure_ID string,
Measure_Start_Quarter string,
Measure_Start_Date string,
Measure_End_Quarter string,
Measure_End_Date
 string )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" =  '"' ,
 "escapeChar" = '\\'
 ) STORED AS TEXTFILE 
LOCATION  '/user/w205/hospital_compare/measures/';
