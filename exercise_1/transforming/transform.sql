
-- drop unused columns
CREATE TABLE complications_hospitals_new AS
SELECT
  provider_id,
  compared_to_national,
  denominator,
  score,
  lower_estimate,
  higher_estimate
FROM complications_hospitals;


-- drop unused columns
CREATE TABLE complications_state_new AS
SELECT
  state,
  measure_id,
  number_of_hospitals_worse,
  number_of_hospitals_same,
  number_of_hospitals_better,
  number_of_hospitals_too_few
FROM complications_state;




-- replace Not Available and provide numeric encoding
CREATE TABLE effective_care_hospitals_new AS
SELECT 
    case when score="Not Available"     then 0
        when score like "Low%"          then 1
        when score like "Medium%"       then 2
        when score like "High%"         then 3
        when score like "Very High%"    then 4
        else provider_id
    end as provider_id,
    condition, measure_id, 
    case when score="Not Available"     then 0
        when score like "Low%"          then 1
        when score like "Medium%"       then 2
        when score like "High%"         then 3
        when score like "Very High%"    then 4
        else score
    end as score, 
        case when sample="Not Available"     then 0
        else sample
    end as sample,
    footnote
    FROM effective_care_hospitals;


-- strip unused columns
CREATE TABLE effective_care_state_new AS
SELECT state, condition, measure_id, score
    FROM effective_care_state;


-- no changes
CREATE TABLE hospitals_new AS SELECT * FROM hospitals;

-- no changes
CREATE TABLE measures_new AS SELECT * FROM measures;

-- strip unused columns
CREATE TABLE readmissions_hospitals_new AS
SELECT provider_id, measure_id, compared_to_national, denominator, score,
        lower_estimate, higher_estimate
FROM readmissions_hospitals;

--strip unused columns
CREATE TABLE readmissions_state_new AS
SELECT state, measure_id, number_of_hospitals_worse, number_of_hospitals_same,
        number_of_hospitals_better, number_of_hospitals_too_few
    FROM readmissions_state;

-- encode NA scores
CREATE TABLE surveys_responses_new AS
SELECT provider_number,
      case when HCAHPS_Base_Score="Not Available" then 0
            else provider_number
      end AS provider_id,
      case when HCAHPS_Base_Score="Not Available" then 0
            else HCAHPS_Base_Score
      end  as HCAHPS_Base_Score,
      case when HCAHPS_Consistency_Score="Not Available" then 0
            else HCAHPS_Consistency_Score
      end  as HCAHPS_Consistency_Score
   FROM surveys_responses;


