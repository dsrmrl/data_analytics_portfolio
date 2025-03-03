CREATE DEFINER=`root`@`localhost` PROCEDURE `get_total_cases_by_location_per_yr`(
_year INT
)
BEGIN
	SELECT 
		`t`.`_Yr`,
        RANK() OVER(ORDER BY `t`.`percent_byYr`DESC) AS _rank ,
		`t`.`location`,
		`t`.`total_cases_perLocation`,
		`t`.`overAll_totalperYr`,
		`t`.`percent_byYr`
	FROM `db_covid`.`total_cases_by_location_per_yr` t
    WHERE _year = `t`.`_Yr`
    ORDER BY 
		`t`.`percent_byYr` DESC;

END