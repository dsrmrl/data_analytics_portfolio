CREATE DEFINER=`root`@`localhost` PROCEDURE `get_summary_by_transportation_mode`(
transportation_mode VARCHAR(25)
)
BEGIN
	SELECT *
    FROM `view_transportation_data`
    WHERE 
    `view_transportation_data`.`mode` = transportation_mode
ORDER BY year DESC;

END