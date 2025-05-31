## stored procedure script created in the UI

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top3_by_recall_type_by_year`(
year INT
)
BEGIN
	SELECT *
	FROM top3_recall_type_by_year d
    WHERE year = d.year ;
END
