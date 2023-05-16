SELECT
	column_name,
	data_type
FROM
	information_schema."columns"
WHERE
		table_name = 'TABLE_NAME'
	AND is_nullable = 'NO'
	AND is_identity = 'NO'
ORDER BY
	ordinal_position 
;
