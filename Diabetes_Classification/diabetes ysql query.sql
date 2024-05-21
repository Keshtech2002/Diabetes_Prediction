RENAME TABLE diabetes_binary_5050split_health_indicators_brfss2015_edited TO diabetes_5050split;
# Relationship between Blood presure and diabetes 
SELECT Diabetes_binary, HighBP,
		COUNT(HighBP) AS Bp_frequency
FROM diabetes_query.diabetes_5050split
GROUP BY HighBP, Diabetes_binary
;
#My results confirm the positive relationship between diabtes and high Bp 



# Can BMI be an indicator of diabetes?
SELECT Diabetes_binary,
    CASE 
        WHEN BMI BETWEEN 0 AND 18.4 THEN 'Under weight'
        WHEN BMI BETWEEN 18.5 AND 24.9 THEN 'Normal weight'
        WHEN BMI BETWEEN 25 AND 29.9 THEN 'Over weight'
        WHEN BMI BETWEEN 30 AND 34.9 THEN 'Obesity'
        WHEN BMI BETWEEN 35 AND 39.9 THEN 'Obesity 1'
        WHEN BMI BETWEEN 40 AND 100 THEN 'Severe Obesity'
        ELSE 'Other' 
    END AS BMI_range,
    COUNT(*) AS frequency 
FROM diabetes_query.diabetes_5050split
GROUP BY BMI_range, Diabetes_binary
ORDER BY Diabetes_binary, frequency DESC, BMI_range ;
    
# Relationship between income and diabetes 
SELECT Diabetes_binary, income_scale,
		COUNT(Income_scale) AS income_categories_freq
FROM diabetes_query.diabetes_5050split
GROUP BY  income_scale, Diabetes_binary
ORDER BY Diabetes_binary, income_categories_freq DESC, income_scale
;



# relationship between diabetes and cholesterol and percentage of individuals more or less affected 
SELECT diabetes_5050split.Diabetes_binary, 
		diabetes_5050split.HighChol,
		COUNT(diabetes_5050split.HighChol) AS Chol_frequency,
		COUNT(diabetes_5050split.HighChol) / total_count * 100 AS Chol_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
) 
AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.HighChol, 
		  diabetes_5050split.Diabetes_binary
;


    
# Is heart attack linked to diabetes ?    
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN HeartDiseaseorAttack = 0 THEN "No"
        WHEN HeartDiseaseorAttack = 1 THEN "Yes"
		END AS Heart_attack,
		COUNT(diabetes_5050split.HeartDiseaseorAttack) AS frequency,
        COUNT(diabetes_5050split.HeartDiseaseorAttack)/ total_count * 100 AS heart_attack_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		Heart_attack
ORDER BY Diabetes_binary, 
		frequency, Heart_attack
;



# Does smoking increase chances of diabeyes?
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN Smoker = 0 THEN "No"
        WHEN Smoker = 1 THEN "Yes"
		END AS smoker_response,
		COUNT(diabetes_5050split.Smoker) AS frequency,
        COUNT(diabetes_5050split.Smoker)/ total_count * 100 AS smoking_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		smoker_response
ORDER BY Diabetes_binary, 
		frequency, smoker_response
;



# Does being an alchoholic increase chances of diabetes?
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN HvyAlcoholConsump = 0 THEN "No"
        WHEN HvyAlcoholConsump = 1 THEN "Yes"
		END AS alcoholic_response,
		COUNT(diabetes_5050split.HvyAlcoholConsump) AS frequency,
        COUNT(diabetes_5050split.HvyAlcoholConsump)/ total_count * 100 AS alchoholic_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		alcoholic_response
ORDER BY Diabetes_binary, 
		frequency, alcoholic_response
;



# does consuming fruits prevent diabetes
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN Fruit = 0 THEN "No"
        WHEN Fruit = 1 THEN "Yes"
		END AS Fruit_consumption,
		COUNT(diabetes_5050split.Fruit) AS frequency,
        COUNT(diabetes_5050split.Fruit)/ total_count * 100 AS consumption_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		Fruit_consumption
ORDER BY Diabetes_binary, 
		frequency, Fruit_consumption
;



# What effect does vegetables have if any
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN Veggies = 0 THEN "No"
        WHEN Veggies = 1 THEN "Yes"
		END AS veggies_consumption,
		COUNT(diabetes_5050split.Veggies) AS frequency,
        COUNT(diabetes_5050split.Veggies)/ total_count * 100 AS consumption_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		veggies_consumption
ORDER BY Diabetes_binary, 
		frequency, veggies_consumption
;



# Healthcare coverage 
SELECT diabetes_5050split.Diabetes_binary,  
		CASE 
        WHEN AnyHealthcare = 0 THEN "No"
        WHEN AnyHealthcare = 1 THEN "Yes"
		END AS Health_coverage,
		COUNT(diabetes_5050split.Veggies) AS frequency,
        COUNT(diabetes_5050split.Veggies)/ total_count * 100 AS coverage_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY diabetes_5050split.Diabetes_binary, 
		Health_coverage
ORDER BY Diabetes_binary, 
		frequency, Health_coverage
;


# How many days in a month is general mental well being affected
SELECT diabetes_5050split.Diabetes_binary,
CASE 
        WHEN MentHlth_scale BETWEEN 0 AND 10 THEN 'Mild'
        WHEN MentHlth_scale BETWEEN 11 AND 20 THEN 'Intermediate'
        WHEN MentHlth_scale BETWEEN 21 AND 30 THEN 'Severe'
    END AS MentalHealth_range,
    COUNT(diabetes_5050split.MentHlth_scale) AS frequency,
        COUNT(diabetes_5050split.MentHlth_scale)/ total_count * 100 AS  freq_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY MentalHealth_range, Diabetes_binary
ORDER BY Diabetes_binary, frequency DESC, MentalHealth_range
;



# What age group is most affected
SELECT diabetes_5050split.Diabetes_binary, diabetes_5050split.Age_intervals,
		COUNT(diabetes_5050split.Age_intervals) AS agegroup_freq,
        COUNT(diabetes_5050split.Age_intervals)/ total_count * 100 AS  freq_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
GROUP BY   Age_intervals, Diabetes_binary
ORDER BY Diabetes_binary, agegroup_freq DESC,  Age_intervals
;


#who is more  suceptible male or femal?
SELECT diabetes_5050split.Diabetes_binary, diabetes_5050split.sex, 
	COUNT(diabetes_5050split.Sex) AS Freq,
     COUNT(diabetes_5050split.sex)/ total_count * 100 AS  freq_percentage
FROM diabetes_query.diabetes_5050split
JOIN (
    SELECT Diabetes_binary, 
			COUNT(*) AS total_count
    FROM diabetes_query.diabetes_5050split
    GROUP BY Diabetes_binary
    )
    AS total_counts ON diabetes_query.diabetes_5050split.Diabetes_binary = total_counts.Diabetes_binary
	GROUP BY sex, Diabetes_binary
;


select*
from diabetes_query.diabetes_5050split;