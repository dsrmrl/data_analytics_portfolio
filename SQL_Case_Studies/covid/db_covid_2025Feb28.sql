
-- USE db_covid ;
-- survival and mortality rate per year by continent
SELECT 
	*
    , DENSE_RANK() OVER(PARTITION BY continent ORDER BY round((_diff/ _total_cases) * 100,1) DESC) AS rank_survival
    , round((_diff/ _total_cases) * 100,1) AS survival_rate
    , round((_total_deaths / _total_cases) * 100,1) AS mortality_rate
FROM 
(
	SELECT 
		DISTINCT `owid-covid-data`.`continent`,
		year(`owid-covid-data`.`date`) AS _Yr,
		RANK() OVER(PARTITION BY continent 
			ORDER BY SUM( `owid-covid-data`.`total_cases`) DESC) AS rank_cases ,
		SUM( `owid-covid-data`.`total_cases`) AS _total_cases,
		RANK() OVER(PARTITION BY continent 
			ORDER BY SUM( `owid-covid-data`.`total_deaths`) DESC) AS rank_deaths ,
		SUM( `owid-covid-data`.`total_deaths`) AS _total_deaths,
		SUM( `owid-covid-data`.`total_cases`) -SUM( `owid-covid-data`.`total_deaths`) AS _diff
	FROM `db_covid`.`owid-covid-data`
	GROUP BY 
		`owid-covid-data`.`continent`,
		year(`owid-covid-data`.`date`)
	
) t
ORDER BY 
		continent,
		_Yr DESC ;


SELECT 
   DISTINCT `owid-covid-data`.`continent` _continent , 
    sum(`owid-covid-data`.`total_cases`) _total_cases , 
    sum(`owid-covid-data`.`new_cases`) _new_cases , 
	sum(`owid-covid-data`.`total_deaths`) _total_deaths , 
    sum(`owid-covid-data`.`new_deaths`) _new_deaths , 
    sum(`owid-covid-data`.`icu_patients`) _icu_patients , 
    sum(`owid-covid-data`.`hosp_patients`) _hosp_patients , 
    sum(`owid-covid-data`.`total_tests`) _total_tests , 
    round(avg(`owid-covid-data`.`positive_rate`),2) avg_positive_rate , 
    round(sum(`owid-covid-data`.`tests_per_case`),1) _tests_per_case , 
    # sum(`owid-covid-data`.`tests_units`) _tests_units , 
    sum(`owid-covid-data`.`total_vaccinations`) _total_vaccinations , 
    sum(`owid-covid-data`.`people_vaccinated`) _people_vaccinated , 
    sum(`owid-covid-data`.`people_fully_vaccinated`) _people_fully_vaccinated , 
    sum(`owid-covid-data`.`total_boosters`) _total_boosters , 
    sum(`owid-covid-data`.`new_vaccinations`) _new_vaccinations , 
    round(sum(`owid-covid-data`.`stringency_index`),1)_stringency_index , 
    round(avg(`owid-covid-data`.`population_density`),1) avg_population_density ,
    round(avg(`owid-covid-data`.`median_age`),1) avg_median_age , 
    round(sum(`owid-covid-data`.`aged_65_older`),1) _aged_65_older , 
    round(sum(`owid-covid-data`.`aged_70_older`),1) _aged_70_older , 
    round(avg(`owid-covid-data`.`gdp_per_capita`),1) avg_gdp_per_capita , 
    round(sum(`owid-covid-data`.`extreme_poverty`),1) _extreme_poverty , 
    round(avg(`owid-covid-data`.`cardiovasc_death_rate`),1) avg_cardiovasc_death_rate , 
    round(avg(`owid-covid-data`.`diabetes_prevalence`),1) avg_diabetes_prevalence , 
    round(sum(`owid-covid-data`.`female_smokers`),1) _female_smokers , 
    round(sum(`owid-covid-data`.`male_smokers`),1) _male_smokers, 
    round(sum(`owid-covid-data`.`handwashing_facilities`),1) _handwashing_facilities , 
    round(sum(`owid-covid-data`.`hospital_beds_per_thousand`),1) _hospital_beds_per_thousand , 
    round(avg(`owid-covid-data`.`life_expectancy`),1) avg_life_expectancy , 
    round(sum(`owid-covid-data`.`human_development_index`),1) _human_development_index , 
    round(sum(`owid-covid-data`.`population`),1) _population , 
    round(avg(`owid-covid-data`.`excess_mortality`),1) avg_excess_mortality
FROM `db_covid`.`owid-covid-data`
GROUP BY 
	`owid-covid-data`.`continent` ;
