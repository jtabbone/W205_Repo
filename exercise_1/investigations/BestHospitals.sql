select hospitals_new.hospital_name, sum(score*sample) as agg_score 
from hospitals_new, effective_care_hospitals_new 
where hospitals_new.provider_id > 5 
AND hospitals_new.provider_id == effective_care_hospitals_new.provider_id 
GROUP BY hospitals_new.hospital_name 
ORDER BY agg_score 
DESC limit 10;