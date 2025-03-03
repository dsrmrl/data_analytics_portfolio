CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top10_in_total_cases_per_yr`(
_yr INT
)
BEGIN
	SELECT 
    `_rank`,
    `_Yr`,
    `continent`,
    `location`,
   `_total_case`
FROM `db_covid`.`top10_in_total_cases_per_year` t
WHERE _yr = t._Yr ;

END