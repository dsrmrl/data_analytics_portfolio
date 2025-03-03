CREATE DEFINER=`root`@`localhost` PROCEDURE `get_totalcase_summary_by_location`(
location TEXT
)
BEGIN
	SELECT 
    `t`.`_Yr`,
    `t`.`location`,
    `t`.`total_cases_perLocation`,
    `t`.`overAll_totalperYr`,
    `t`.`percent_byYr`
	FROM `db_covid`.`total_cases_by_location_per_yr` t
    WHERE location = t.location ;

END