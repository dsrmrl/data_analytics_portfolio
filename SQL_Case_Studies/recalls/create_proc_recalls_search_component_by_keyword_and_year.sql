CREATE DEFINER=`root`@`localhost` PROCEDURE `search_component_keyword`(
IN pattern VARCHAR(100),
`year` INT
)
BEGIN

  SELECT 
	YEAR(`date`) AS `year`
    , manufacturer
    , `component`
    , recall_type 
    , potentially_affected
  FROM recalls_data_cleaned d
  WHERE `component` REGEXP pattern AND `year` = YEAR(`date`);

END