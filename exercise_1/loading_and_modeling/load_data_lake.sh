#/bin/bash

# Declare some imprtant variables for file locations
DATA_SETS='/data/datasets'
TARBALL="$DATA_SETS/Hospital_Revised_Flatfiles.tar"
HOSPITAL_FILES="Hospital_Revised_Flatfiles"
OP_PATH="$DATA_SETS/$HOSPITAL_FILES"

# This array contains some interesting files from the tar file
declare -a hospital_tar=('Hospital General Information.csv'
    'Timely and Effective Care - Hospital.csv'
    'Timely and Effective Care - State.csv'
    'Readmissions and Deaths - Hospital.csv'
    'Readmissions and Deaths - State.csv'
    'Measure Dates.csv'
    'Complications - Hospital.csv'
    'Complications - State.csv'
    'hvbp_hcahps_05_28_2015.csv')

# This array has the prefered names (no space) of the above files
declare -a hospital_csv=('hospitals' 
    'effective_care_hospitals'
    'effective_care_state'
    'readmissions_hospitals'
    'readmissions_state'
    'measures'
    'complications_hospitals'
    'complications_state'
    'surveys_responses') 


# Extract files in tarball.  Not comitting
# to use all of them, but we can extract some 
# that look interesting
cd $DATA_SETS
echo "Untaring files"
for file in "${hospital_tar[@]}"
do
    tar -xvf $TARBALL  "$HOSPITAL_FILES/$file"
done

#
# Rename the files anf append .tmp extention
#
echo "Renaming Files"
cd $HOSPITAL_FILES
for index in ${!hospital_csv[*]}
do
    mv "${hospital_tar[$index]}" ${hospital_csv[$index]}.tmp
done


#
# Strip header lines from .tmp files
# save that line, we will use it to create the sql to create the tables
# rename stripped .tmp file to .csv
#
echo "Stripping header line"

for index in ${!hospital_csv[*]}
do
    # Strip header line
    head -n 1 ${hospital_csv[$index]}.tmp | sed -e 's/ /_/g' > ${hospital_csv[$index]}.header
    # rest of file is csv
    tail -n +2 ${hospital_csv[$index]}.tmp > ${hospital_csv[$index]}.csv

    # use the header file to create default tables sql create scripts.  Store everything as a string
    # This is useful for me because I can create these tables in MySQL and it will generate an Entity
    # Relationship diagram that I can start with.
    echo "CREATE TABLE  ${hospital_csv[$index]} (" > ${hospital_csv[$index]}.sql
    cat ${hospital_csv[$index]}.header | sed 's/,/ varchar(255),\n/g' >> ${hospital_csv[$index]}.sql
    echo ' varchar(255) );' >> ${hospital_csv[$index]}.sql

    # Create command to create database
    echo 'CREATE DATABASE IF NOT EXISTS HOSPITAL_COMPARE;' > $OP_PATH/create_db.sql 

    # Create command to drop all tables
    echo "DROP TABLE HOSPITAL_COMPARE.${hospital_csv[$index]};" >> $OP_PATH/drop_tables.sql

    # Use header to create ddl file
    hdfs dfs -mkdir /user/w205/hospital_compare/${hospital_csv[$index]}

    echo "CREATE EXTERNAL TABLE HOSPITAL_COMPARE.${hospital_csv[$index]} (" >> ${hospital_csv[$index]}.ddl
    cat ${hospital_csv[$index]}.header | sed 's/"//g' | sed 's/,/ string,\n/g' >> ${hospital_csv[$index]}.ddl
    echo " string )" >> ${hospital_csv[$index]}.ddl
    echo "ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES ("  >> ${hospital_csv[$index]}.ddl
    echo ' "separatorChar" = ","'',' >> ${hospital_csv[$index]}.ddl
    # LOL Those quotes read double-single-double single-double-single double-single-double
    # In essence, I alternate " ' " for a single quote or ' " ' for a double quote  and concatanate characters 
    echo ' "quoteChar" = ' "'"'"'"'" ','   >> ${hospital_csv[$index]}.ddl
    echo ' "escapeChar" = '"'"'\''\'"'"  >> ${hospital_csv[$index]}.ddl
    echo ' ) STORED AS TEXTFILE '>> ${hospital_csv[$index]}.ddl
    # Funny but I cant get it working properly by including the file name in the path, only a directory
    # and if all the files are in the same directory, the ddl runs but does not return correct queries
    echo 'LOCATION ' "'""/user/w205/hospital_compare/${hospital_csv[$index]}/""';"  >> ${hospital_csv[$index]}.ddl
done

# remove tmp files
echo "Cleaning temporary files"
rm *.tmp
#echo "Done!"

# Load files into dfs
#hdfs dfs -mkdir /user/w205/hospital_compare
echo "Loading files to hdfs"
cd $DATA_SETS
cd $HOSPITAL_FILES

for index in ${!hospital_csv[*]}
do
	echo "moving file: ${hospital_csv[$index]}"
	hdfs dfs -put /data/datasets/Hospital_Revised_Flatfiles/${hospital_csv[$index]}.csv /user/w205/hospital_compare/${hospital_csv[$index]}/${hospital_csv[$index]}.csv
done

# Cat .ddl.sql files to make one
cat *.ddl >> hive_base_ddl.ddl

