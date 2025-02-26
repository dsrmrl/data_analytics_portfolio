CREATE DEFINER=`root`@`localhost` PROCEDURE `get_transportation_data_by_year`(
    IN _year INT
)
BEGIN
    SELECT 
        `year`,
        `mode`,
        `ave_distance_per_trip`
    FROM `view_transportation_data`
    WHERE `year` = _year;  

END