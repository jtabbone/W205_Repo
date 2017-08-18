USE VIDS;

DROP TABLE IF EXISTS patient;

CREATE TABLE patient (
id string,
hospital_id string,
p_name string,
temperature string,
bp_systolic string,
bp_diastolic string,
resp_rate string,
pulse string,
o2saturation string,
pain string,
consciousness string,
urineoutput string,
time_stamp string
);
