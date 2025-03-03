
-- USE db_covid.`owid-covid-data`;
SELECT * FROM db_covid.`owid-covid-data`;

-- total deaths percentage per continent
SELECT 
	*
    , sum(total_deaths_perContinent) OVER() AS _overAll_total_deaths 
    ,ROUND((total_deaths_perContinent / sum(total_deaths_perContinent) OVER()) 
		* 100,2) AS percentage
FROM 
	(
			SELECT
				continent
				, sum(total_deaths) AS total_deaths_perContinent
			FROM db_covid.`owid-covid-data`
			GROUP BY continent  
	) t
ORDER BY percentage DESC ;


	

