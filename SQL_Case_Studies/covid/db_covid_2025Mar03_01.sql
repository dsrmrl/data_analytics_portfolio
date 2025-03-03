SELECT * FROM db_covid.total_deaths_percentage_percontinent;

-- create new table with selected columns from main table
DROP TABLE IF EXISTS `covid_data_rev` ;
CREATE TABLE `covid_data_rev` AS
	SELECT 
		`owid-covid-data`.`iso_code`,
		`owid-covid-data`.`continent`,
        `owid-covid-data`.`date`,
		`owid-covid-data`.`total_cases`,
		`owid-covid-data`.`total_deaths`,
		`owid-covid-data`.`reproduction_rate`,
		`owid-covid-data`.`icu_patients`,
		`owid-covid-data`.`hosp_patients`,
		`owid-covid-data`.`total_tests`,
		`owid-covid-data`.`total_vaccinations`,
		`owid-covid-data`.`people_vaccinated`,
		`owid-covid-data`.`people_fully_vaccinated`,
		`owid-covid-data`.`stringency_index`,
		`owid-covid-data`.`population_density`,
		`owid-covid-data`.`median_age`,
		`owid-covid-data`.`aged_65_older`,
		`owid-covid-data`.`aged_70_older`,
		`owid-covid-data`.`gdp_per_capita`,
		`owid-covid-data`.`extreme_poverty`,
		`owid-covid-data`.`cardiovasc_death_rate`,
		`owid-covid-data`.`diabetes_prevalence`,
		`owid-covid-data`.`female_smokers`,
		`owid-covid-data`.`male_smokers`,
		`owid-covid-data`.`handwashing_facilities`,
		`owid-covid-data`.`life_expectancy`,
		`owid-covid-data`.`human_development_index`,
		`owid-covid-data`.`population`
	FROM `db_covid`.`owid-covid-data`;


# -- replace '' with NULL    
# UPDATE db_covid.`owid-covid-data`
# SET total_tests = NULLIF(total_tests, '') ;

# -- check and count distinct values
# SELECT 
# 	DISTINCT(total_tests)
#     , count(*)
# FROM db_covid.`covid_data_rev`
# GROUP BY total_tests ;
#  
# -- modify data type
# ALTER TABLE `covid_data_rev`
# MODIFY COLUMN total_tests DOUBLE ;


-- summary of cases per vaccinations and population per continent
SELECT 
    `covid_data_rev`.`continent` continent,
    sum(`covid_data_rev`.`total_cases`)  t_cases,
    sum(`covid_data_rev`.`total_deaths`) t_deaths,
	sum(`covid_data_rev`.`total_vaccinations`) t_vaccinations,
    sum(`covid_data_rev`.`people_vaccinated`) t_vaccinated,
    sum(`covid_data_rev`.`people_fully_vaccinated`) t_fullyvaccinated,
    round(sum(`covid_data_rev`.`population_density`),2) pop_density,
    sum(`covid_data_rev`.`population`) population
FROM `db_covid`.`covid_data_rev`
GROUP BY `covid_data_rev`.`continent` ;


-- Rank comparison in total cases, total deaths and vaccination 
	-- Ranking is done in descending order, with the highest value ranked as 1st place
	-- Highest total cases → Indicates which continent had the most infections
	-- Highest total deaths → Reveals which continent suffered the most fatalities
SELECT 
	continent
    , RANK() OVER(ORDER BY t_cases DESC) AS r_cases
    , t_cases
    , RANK() OVER(ORDER BY t_deaths DESC) AS r_cases
    , t_deaths
    , RANK() OVER(ORDER BY t_vaccinations DESC) AS r_vax
    , t_vaccinations
    , RANK() OVER(ORDER BY t_vaccinated DESC) AS r_vaxx
    , t_vaccinated
    , RANK() OVER(ORDER BY t_fullyvaccinated DESC) AS r_fullvax
    , t_fullyvaccinated
FROM db_covid.cases_per_vaxx_and_population_percontinent;


	-- Vaccination-to-case ratio → A high ratio suggests a strong response in mitigating infections
	-- Vaccination-to-death ratio → Helps understand how vaccines may have reduced mortality
SELECT 
	continent
    , RANK() OVER(ORDER BY t_cases DESC) AS r_cases
    , t_cases
    , RANK() OVER(ORDER BY t_deaths DESC) AS r_deaths
    , t_deaths
	, RANK() OVER(ORDER BY t_vaccinations DESC) AS r_vax
    , t_vaccinations
    , round((t_vaccinations/ t_cases),2) AS vax_to_case_ratio
    , round((t_vaccinations/ t_deaths),2) AS vax_to_deaths_ratio
FROM db_covid.cases_per_vaxx_and_population_percontinent;


-- Rank comparison in total cases, total deaths and population
	-- Ranking is done in descending order, with the highest value ranked as 1st place
SELECT 
	continent
	, RANK() OVER(ORDER BY t_cases DESC) AS r_cases
    , t_cases
    , RANK() OVER(ORDER BY t_deaths DESC) AS r_deaths
    , t_deaths
    , RANK() OVER(ORDER BY pop_density DESC) AS r_popdensity
    , pop_density
    , RANK() OVER(ORDER BY population DESC) AS r_population
    , population
FROM db_covid.cases_per_vaxx_and_population_percontinent;
 
-- total deaths to population ratio 
SELECT 
	continent
    , population
    , t_deaths
    , RANK() OVER(ORDER BY pop_density DESC) AS r_popdensity
    , pop_density
    , (t_deaths/population) *100 AS deaths_to_pop_ratio
FROM db_covid.cases_per_vaxx_and_population_percontinent
ORDER BY deaths_to_pop_ratio DESC;