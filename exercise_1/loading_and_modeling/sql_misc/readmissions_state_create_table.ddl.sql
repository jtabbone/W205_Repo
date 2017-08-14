CREATE EXTERNAL TABLE HOSPITAL_COMPARE.readmissions_state (
State string,
Measure_Name string,
Measure_ID string,
Number_of_Hospitals_Worse string,
Number_of_Hospitals_Same string,
Number_of_Hospitals_Better string,
Number_of_Hospitals_Too_Few string,
Footnote string,
Measure_Start_Date string,
Measure_End_Date
 string )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" =  '"' ,
 "escapeChar" = '\\'
 ) STORED AS TEXTFILE 
