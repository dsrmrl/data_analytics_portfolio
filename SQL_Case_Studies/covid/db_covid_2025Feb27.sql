USE db_covid;

SELECT * FROM db_covid.`owid-covid-data`;

-- show column names, data type , column type of the table
SHOW COLUMNS 
FROM db_covid.`owid-covid-data`;

-- change data type of date column
ALTER TABLE `owid-covid-data`
MODIFY COLUMN `date` DATE;


-- identify if there are non-numeric values in numeric columns
SELECT * FROM db_covid.`owid-covid-data`
WHERE 
	new_cases_smoothed  REGEXP '[^0-9.-]' OR
	new_deaths_smoothed REGEXP '[^0-9.-]' OR
	new_cases_smoothed_per_million REGEXP '[^0-9.-]' OR
    new_deaths_smoothed_per_million REGEXP '[^0-9.-]' OR
    reproduction_rate  REGEXP '[^0-9.-]' OR
    icu_patients  REGEXP '[^0-9.-]' OR
    icu_patients_per_million REGEXP '[^0-9.-]' OR
    hosp_patients REGEXP '[^0-9.-]' OR
    hosp_patients_per_million REGEXP '[^0-9.-]' OR
    weekly_icu_admissions REGEXP '[^0-9.-]' OR
    weekly_icu_admissions_per_million REGEXP '[^0-9.-]' OR
    weekly_hosp_admissions  REGEXP '[^0-9.-]' OR
    weekly_hosp_admissions_per_million REGEXP '[^0-9.-]' OR
    total_tests  REGEXP '[^0-9.-]' OR
	new_tests REGEXP '[^0-9.-]' OR
    total_tests_per_thousand REGEXP '[^0-9.-]' OR
    new_tests_per_thousand REGEXP '[^0-9.-]' OR
    new_tests_smoothed REGEXP '[^0-9.-]' OR
	new_tests_smoothed_per_thousand REGEXP '[^0-9.-]' OR
    positive_rate  REGEXP '[^0-9.-]' OR
	tests_per_case  REGEXP '[^0-9.-]' OR
	tests_units  REGEXP '[^0-9.-]' OR
    total_vaccinations  REGEXP '[^0-9.-]' OR
	people_vaccinated  REGEXP '[^0-9.-]' OR
	people_fully_vaccinated REGEXP '[^0-9.-]' OR
	total_boosters  REGEXP '[^0-9.-]' OR
	new_vaccinations  REGEXP '[^0-9.-]' OR
	new_vaccinations_smoothed  REGEXP '[^0-9.-]' OR 
    total_vaccinations_per_hundred REGEXP '[^0-9.-]' OR
    people_vaccinated_per_hundred REGEXP '[^0-9.-]' OR
    people_fully_vaccinated_per_hundred REGEXP '[^0-9.-]' OR
    total_boosters_per_hundred REGEXP '[^0-9.-]' OR
    new_vaccinations_smoothed_per_million REGEXP '[^0-9.-]' OR
    new_people_vaccinated_smoothed  REGEXP '[^0-9.-]' OR
    new_people_vaccinated_smoothed_per_hundred REGEXP '[^0-9.-]' OR
    extreme_poverty REGEXP '[^0-9.-]' OR
    female_smokers REGEXP '[^0-9.-]' OR
    male_smokers REGEXP '[^0-9.-]' OR
    excess_mortality_cumulative_absolute REGEXP '[^0-9.-]' OR
    excess_mortality_cumulative REGEXP '[^0-9.-]' OR
    excess_mortality REGEXP '[^0-9.-]' OR
    excess_mortality_cumulative_per_million REGEXP '[^0-9.-]';


-- convert empty string ('') to NULL
UPDATE db_covid.`owid-covid-data`
SET 
    new_cases_smoothed = NULLIF(new_cases_smoothed, ''),
    new_deaths_smoothed = NULLIF(new_deaths_smoothed, ''),
    new_cases_smoothed_per_million = NULLIF(new_cases_smoothed_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(reproduction_rate, ''),
    icu_patients = NULLIF(icu_patients, ''),
    icu_patients_per_million = NULLIF(icu_patients_per_million, ''),
    hosp_patients = NULLIF(hosp_patients, ''),
    hosp_patients_per_million = NULLIF(hosp_patients_per_million, ''),
    weekly_icu_admissions = NULLIF(weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(weekly_icu_admissions_per_million, ''),
    weekly_hosp_admissions = NULLIF(weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = NULLIF(weekly_hosp_admissions_per_million, ''),
    total_tests = NULLIF(total_tests, ''),
    new_tests = NULLIF(new_tests, ''),
    total_tests_per_thousand = NULLIF(total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(positive_rate, ''),
    tests_per_case = NULLIF(tests_per_case, ''),
    tests_units = NULLIF(tests_units, ''),
    total_vaccinations = NULLIF(total_vaccinations, ''),
    people_vaccinated = NULLIF(people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(people_fully_vaccinated, ''),
    total_boosters = NULLIF(total_boosters, ''),
    new_vaccinations = NULLIF(new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(people_fully_vaccinated_per_hundred, ''),
    total_boosters_per_hundred = NULLIF(total_boosters_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(new_vaccinations_smoothed_per_million, ''),
    new_people_vaccinated_smoothed = NULLIF(new_people_vaccinated_smoothed, ''),
    new_people_vaccinated_smoothed_per_hundred = NULLIF(new_people_vaccinated_smoothed_per_hundred, ''),
    extreme_poverty = NULLIF(extreme_poverty, ''),
    female_smokers = NULLIF(female_smokers, ''),
    male_smokers = NULLIF(male_smokers, ''),
    excess_mortality_cumulative_absolute = NULLIF(excess_mortality_cumulative_absolute, ''),
    excess_mortality_cumulative = NULLIF(excess_mortality_cumulative, ''),
    excess_mortality = NULLIF(excess_mortality, ''),
    excess_mortality_cumulative_per_million = NULLIF(excess_mortality_cumulative_per_million, '');


-- identify and count rows of columns with non-numeric values
SELECT 'new_cases_smoothed' AS column_name, COUNT(*) AS count_of_issues FROM db_covid.`owid-covid-data` WHERE new_cases_smoothed REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_deaths_smoothed', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_deaths_smoothed REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_cases_smoothed_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_cases_smoothed_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_deaths_smoothed_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_deaths_smoothed_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'reproduction_rate', COUNT(*) FROM db_covid.`owid-covid-data` WHERE reproduction_rate REGEXP '[^0-9.-]'
UNION ALL
SELECT 'icu_patients', COUNT(*) FROM db_covid.`owid-covid-data` WHERE icu_patients REGEXP '[^0-9.-]'
UNION ALL
SELECT 'icu_patients_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE icu_patients_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'hosp_patients', COUNT(*) FROM db_covid.`owid-covid-data` WHERE hosp_patients REGEXP '[^0-9.-]'
UNION ALL
SELECT 'hosp_patients_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE hosp_patients_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'weekly_icu_admissions', COUNT(*) FROM db_covid.`owid-covid-data` WHERE weekly_icu_admissions REGEXP '[^0-9.-]'
UNION ALL
SELECT 'weekly_icu_admissions_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE weekly_icu_admissions_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'weekly_hosp_admissions', COUNT(*) FROM db_covid.`owid-covid-data` WHERE weekly_hosp_admissions REGEXP '[^0-9.-]'
UNION ALL
SELECT 'weekly_hosp_admissions_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE weekly_hosp_admissions_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_tests', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_tests REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_tests', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_tests REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_tests_per_thousand', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_tests_per_thousand REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_tests_per_thousand', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_tests_per_thousand REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_tests_smoothed', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_tests_smoothed REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_tests_smoothed_per_thousand', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_tests_smoothed_per_thousand REGEXP '[^0-9.-]'
UNION ALL
SELECT 'positive_rate', COUNT(*) FROM db_covid.`owid-covid-data` WHERE positive_rate REGEXP '[^0-9.-]'
UNION ALL
SELECT 'tests_per_case', COUNT(*) FROM db_covid.`owid-covid-data` WHERE tests_per_case REGEXP '[^0-9.-]'
UNION ALL
SELECT 'tests_units', COUNT(*) FROM db_covid.`owid-covid-data` WHERE tests_units REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_vaccinations', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_vaccinations REGEXP '[^0-9.-]'
UNION ALL
SELECT 'people_vaccinated', COUNT(*) FROM db_covid.`owid-covid-data` WHERE people_vaccinated REGEXP '[^0-9.-]'
UNION ALL
SELECT 'people_fully_vaccinated', COUNT(*) FROM db_covid.`owid-covid-data` WHERE people_fully_vaccinated REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_boosters', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_boosters REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_vaccinations', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_vaccinations REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_vaccinations_smoothed', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_vaccinations_smoothed REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_vaccinations_per_hundred', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_vaccinations_per_hundred REGEXP '[^0-9.-]'
UNION ALL
SELECT 'people_vaccinated_per_hundred', COUNT(*) FROM db_covid.`owid-covid-data` WHERE people_vaccinated_per_hundred REGEXP '[^0-9.-]'
UNION ALL
SELECT 'people_fully_vaccinated_per_hundred', COUNT(*) FROM db_covid.`owid-covid-data` WHERE people_fully_vaccinated_per_hundred REGEXP '[^0-9.-]'
UNION ALL
SELECT 'total_boosters_per_hundred', COUNT(*) FROM db_covid.`owid-covid-data` WHERE total_boosters_per_hundred REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_vaccinations_smoothed_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_vaccinations_smoothed_per_million REGEXP '[^0-9.-]'
UNION ALL
SELECT 'new_people_vaccinated_smoothed_per_hundred', COUNT(*) FROM db_covid.`owid-covid-data` WHERE new_people_vaccinated_smoothed_per_hundred REGEXP '[^0-9.-]'
UNION ALL
SELECT 'extreme_poverty', COUNT(*) FROM db_covid.`owid-covid-data` WHERE extreme_poverty REGEXP '[^0-9.-]'
UNION ALL
SELECT 'female_smokers', COUNT(*) FROM db_covid.`owid-covid-data` WHERE female_smokers REGEXP '[^0-9.-]'
UNION ALL
SELECT 'male_smokers', COUNT(*) FROM db_covid.`owid-covid-data` WHERE male_smokers REGEXP '[^0-9.-]'
UNION ALL
SELECT 'excess_mortality_cumulative_absolute', COUNT(*) FROM db_covid.`owid-covid-data` WHERE excess_mortality_cumulative_absolute REGEXP '[^0-9.-]'
UNION ALL
SELECT 'excess_mortality_cumulative', COUNT(*) FROM db_covid.`owid-covid-data` WHERE excess_mortality_cumulative REGEXP '[^0-9.-]'
UNION ALL
SELECT 'excess_mortality', COUNT(*) FROM db_covid.`owid-covid-data` WHERE excess_mortality REGEXP '[^0-9.-]'
UNION ALL
SELECT 'excess_mortality_cumulative_per_million', COUNT(*) FROM db_covid.`owid-covid-data` WHERE excess_mortality_cumulative_per_million REGEXP '[^0-9.-]'
ORDER BY count_of_issues DESC;


-- check values from non-numeric column ; (tests_units)
SELECT 
	DISTINCT(tests_units)
    , count(*)
FROM `owid-covid-data`
GROUP BY (tests_units) ;

-- tests_units is actually a text column and not a numeric column

-- modify column data types
ALTER TABLE db_covid.`owid-covid-data`
MODIFY COLUMN new_cases_smoothed DOUBLE,
MODIFY COLUMN new_deaths_smoothed DOUBLE,
MODIFY COLUMN new_cases_smoothed_per_million DOUBLE,
MODIFY COLUMN new_deaths_smoothed_per_million DOUBLE,
MODIFY COLUMN reproduction_rate DOUBLE, 
MODIFY COLUMN icu_patients INT, 
MODIFY COLUMN icu_patients_per_million DOUBLE,
MODIFY COLUMN hosp_patients INT, 
MODIFY COLUMN hosp_patients_per_million DOUBLE,
MODIFY COLUMN weekly_icu_admissions INT, 
MODIFY COLUMN weekly_icu_admissions_per_million DOUBLE,  
MODIFY COLUMN weekly_hosp_admissions INT, 
MODIFY COLUMN weekly_hosp_admissions_per_million DOUBLE,
MODIFY COLUMN new_tests  INT, 
MODIFY COLUMN total_tests_per_thousand DOUBLE,
MODIFY COLUMN new_tests_per_thousand DOUBLE,
MODIFY COLUMN new_tests_smoothed DOUBLE,  
MODIFY COLUMN new_tests_smoothed_per_thousand DOUBLE,
MODIFY COLUMN positive_rate DOUBLE,
MODIFY COLUMN tests_per_case  DOUBLE,
MODIFY COLUMN total_vaccinations DOUBLE,
MODIFY COLUMN people_vaccinated DOUBLE,
MODIFY COLUMN people_fully_vaccinated DOUBLE, 
MODIFY COLUMN total_boosters INT, 
MODIFY COLUMN new_vaccinations INT, 
MODIFY COLUMN new_vaccinations_smoothed DOUBLE,
MODIFY COLUMN total_vaccinations_per_hundred DOUBLE,
MODIFY COLUMN people_vaccinated_per_hundred DOUBLE,
MODIFY COLUMN people_fully_vaccinated_per_hundred DOUBLE,
MODIFY COLUMN total_boosters_per_hundred DOUBLE,
MODIFY COLUMN new_vaccinations_smoothed_per_million DOUBLE,
MODIFY COLUMN new_people_vaccinated_smoothed DOUBLE,
MODIFY COLUMN new_people_vaccinated_smoothed_per_hundred DOUBLE,
MODIFY COLUMN extreme_poverty DOUBLE,
MODIFY COLUMN female_smokers DOUBLE,
MODIFY COLUMN male_smokers DOUBLE,
MODIFY COLUMN excess_mortality_cumulative_absolute DOUBLE,
MODIFY COLUMN excess_mortality_cumulative DOUBLE,
MODIFY COLUMN excess_mortality DOUBLE,
MODIFY COLUMN excess_mortality_cumulative_per_million DOUBLE ;

-- refresh the schema
FLUSH TABLES;

-- end of data cleaning


-- data exploration
-- checking for duplicates
SELECT 
	*
FROM 
(
	SELECT 
		DISTINCT `date`
		, location
		, ROW_NUMBER() OVER(PARTITION BY location,`date` ORDER BY `date`) AS rn
	FROM db_covid.`owid-covid-data`
	GROUP BY `date`, location
) t 
WHERE rn > 1;

-- retrieve distinct continents ; 6 rows returned
SELECT 
	 DISTINCT continent
FROM db_covid.`owid-covid-data`;

-- retrieve distinct location ; 62 rows returned
SELECT 
	 DISTINCT location
     FROM db_covid.`owid-covid-data`;


-- check date duration; returned year 2020 to 2024
SELECT 
	 min(year(date)) AS frYr
     , max(year(date)) AS toYr
FROM db_covid.`owid-covid-data`;

-- total cases per year overall
SELECT 
	 year(date) AS _year
     ,sum(total_cases) AS total_cases
     , RANK() OVER(ORDER BY sum(total_cases)  DESC) AS _rank
FROM db_covid.`owid-covid-data`
GROUP BY year(date)
ORDER BY _year ;

-- summary per year
SELECT
	_year
    , total_cases AS currYr
    , LAG(total_cases,1) OVER(ORDER BY _year) AS PrevYr
    , SUM(total_cases) OVER() AS total
    ,ROUND(CAST(total_cases - LAG(total_cases,1) OVER(ORDER BY _year) AS FLOAT)
		/LAG(total_cases,1) OVER(ORDER BY _year) *100,1) 
		AS YoYPercent
	,ROUND(CAST(total_cases AS FLOAT) / SUM(total_cases) OVER() * 100,1) AS currYrPercent
FROM (
	   SELECT 
			 year(date) AS _year
			 ,sum(total_cases) AS total_cases
			 , RANK() OVER(ORDER BY sum(total_cases) DESC) AS _rank
		FROM db_covid.`owid-covid-data`
		GROUP BY year(date)
	) t ;

-- 
SELECT 
	 year(date) AS _year
	 ,continent
	 ,sum(total_cases) AS total_cases
	 , RANK() OVER(PARTITION BY year(date)
	 ORDER BY sum(total_cases) DESC) AS _rank
FROM db_covid.`owid-covid-data`
GROUP BY 
	year(date) 
	, continent ;



-- total cases summary by location and year
SELECT 
	*
    , LAG(total_cases_perLocation,1) OVER(PARTITION BY location 
    ORDER BY _Yr) AS PrevYr
    , (total_cases_perLocation - LAG(total_cases_perLocation,1) 
    OVER(PARTITION BY location ORDER BY _Yr))
    AS variance
     ,sum(total_cases_perLocation) OVER (PARTITION BY _Yr) AS overAll_totalperYr
     ,ROUND(CAST(total_cases_perLocation AS FLOAT) / sum(total_cases_perLocation) 
     OVER (PARTITION BY _Yr)  * 100 ,2) AS percent_byYr
FROM 
(
		SELECT 
			year(date) AS _Yr
			, location
			,sum(total_cases) AS total_cases_perLocation
		FROM `db_covid`.`owid-covid-data`
		GROUP BY 
			year(date)
			, location
		ORDER BY 
			location
			, year(date)
) t
ORDER BY 
	location
    , _Yr ;
    
-- total cases summary by continent and year
SELECT 
	*
    , RANK() OVER(PARTITION BY continent ORDER BY total_case_perContinent DESC) AS _rank
    , LAG(total_case_perContinent,1) OVER(PARTITION BY continent ORDER BY _Yr) AS PrevYr
    , total_case_perContinent - LAG(total_case_perContinent,1) 
    OVER(PARTITION BY continent ORDER BY _Yr) AS variance
    , SUM(total_case_perContinent) OVER(PARTITION BY continent) AS overAll_totalperContinent
    , (total_case_perContinent /SUM(total_case_perContinent) OVER(PARTITION BY continent)) 
    * 100 AS percent_byContinent
    , SUM(total_case_perContinent) OVER() AS overAll_total
    , (total_case_perContinent / SUM(total_case_perContinent) OVER()) *100
    AS percent_overAll
FROM 
(

		SELECT 
			year(date) AS _Yr
			, continent
			, SUM(total_cases) AS total_case_perContinent
		FROM db_covid.`owid-covid-data`
		GROUP BY 
			year(date) 
			, continent
		ORDER BY 
				continent
				, _Yr
) t ;
 
-- top 5 countries in total cases per continent 		
SELECT 
	continent
    , _rank
    , location
    , _total_cases
FROM 
(
		SELECT 
			`owid-covid-data`.`continent`,
			`owid-covid-data`.`location`,
			SUM(`owid-covid-data`.`total_cases`) AS _total_cases,
			RANK() OVER (PARTITION BY continent ORDER BY SUM(`owid-covid-data`.`total_cases`) DESC)
			AS _rank
			
		FROM `db_covid`.`owid-covid-data`
		GROUP BY 
			`owid-covid-data`.`continent`,
			`owid-covid-data`.`location`
		ORDER BY continent
)	t	
WHERE _rank < 6;

-- top 10 in total cases overall per year
SELECT 
	*
FROM
(
		SELECT
			RANK() OVER(PARTITION BY year(date) ORDER BY SUM(total_cases) DESC) AS _rank
			, year(date) AS _Yr
			, continent
			, location
			, SUM(total_cases) AS _total_case
		FROM db_covid.`owid-covid-data`
		GROUP BY 
			year(date)
			, continent
			, location
		ORDER BY 
			_Yr
			,_total_case DESC 
) t 
WHERE _rank <= 10 ;    

