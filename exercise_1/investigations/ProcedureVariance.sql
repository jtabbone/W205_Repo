select measure_name, variance(effective_care_hospitals_new.score) as var_score,
count(effective_care_hospitals_new.score), 
min(effective_care_hospitals_new.score) ,
max(effective_care_hospitals_new.score),
avg(effective_care_hospitals_new.score), 
std(effective_care_hospitals_new.score) 
from measures_new,effective_care_hospitals_new 
where measures_new.measure_id == effective_care_hospitals_new.measure_id
GROUP BY measure_name
ORDER BY var_score 
DESC limit 10;
