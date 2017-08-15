CREATE EXTERNAL TABLE HOSPITAL_COMPARE.effective_care_state (
State string,
Condition string,
Measure_Name string,
Measure_ID string,
Score string,
Footnote string,
Measure_Start_Date string,
Measure_End_Date
 string )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" =  '"' ,
 "escapeChar" = '\\'
 ) STORED AS TEXTFILE 
LOCATION  '/user/w205/hospital_compare/effective_care_state/';
