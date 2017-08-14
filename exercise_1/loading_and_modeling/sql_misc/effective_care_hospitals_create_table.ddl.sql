CREATE EXTERNAL TABLE HOSPITAL_COMPARE.effective_care_hospitals (
Provider_ID string,
Hospital_Name string,
Address string,
City string,
State string,
ZIP_Code string,
County_Name string,
Phone_Number string,
Condition string,
Measure_ID string,
Measure_Name string,
Score string,
Sample string,
Footnote string,
Measure_Start_Date string,
Measure_End_Date
 string )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
 "separatorChar" = ",",
 "quoteChar" =  '"' ,
 "escapeChar" = '\\'
 ) STORED AS TEXTFILE 
