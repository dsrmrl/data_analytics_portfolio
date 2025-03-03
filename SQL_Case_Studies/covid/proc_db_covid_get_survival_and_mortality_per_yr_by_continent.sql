CREATE DEFINER=`root`@`localhost` PROCEDURE `get_survival_and_mortality_per_yr_by_continent`(
_year INT
)
BEGIN
	SELECT 
		`t`.`continent`,
		`t`.`_Yr`,
		`t`.`survival_rate`,
		`t`.`mortality_rate`
    FROM `db_covid`.`survival_and_mortality_rate_by_yr_per_continent` t
    WHERE _year = t._Yr 
    ORDER BY 
		`t`.`survival_rate` DESC;
END