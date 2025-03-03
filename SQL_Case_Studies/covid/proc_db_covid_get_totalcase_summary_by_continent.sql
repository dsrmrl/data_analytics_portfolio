CREATE DEFINER=`root`@`localhost` PROCEDURE `get_totalcase_summary_by_continent`(
continent TEXT
)
BEGIN
	SELECT 
    `_Yr`,
    `continent`,
    `total_case_perContinent`,
    `_rank`,
    `PrevYr`,
    `variance`,
    `overAll_totalperContinent`,
    `percent_byContinent`
	FROM `db_covid`.`total_cases_by_continent_per_year` t
    WHERE continent = t.continent ;

	
END