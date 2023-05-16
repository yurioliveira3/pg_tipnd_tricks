SELECT  
	(
		SELECT
			r.relname
		FROM
			pg_class r
		WHERE
			r.oid = c.confrelid
	) AS base_table,
	a.attname AS base_col,
	(
		SELECT
			r.relname
		FROM
			pg_class r
		WHERE
			r.oid = c.conrelid
	) AS referencing_table,
	UNNEST(
		(SELECT array_agg(attname) FROM pg_attribute WHERE attrelid = c.conrelid AND ARRAY[attnum] <@ c.conkey)
	) AS referencing_col,
	pg_get_constraintdef(c.oid) AS contraint_sql
FROM
	pg_constraint c
JOIN 
	pg_attribute a ON c.confrelid = a.attrelid AND a.attnum = ANY(confkey)	
WHERE
	c.confrelid != c.conrelid AND 
 	(
		SELECT
			r.relname
		FROM
			pg_class r
		WHERE
			r.oid = c.confrelid
	) = 'TABLE_NAME'
-- ORDER BY 
--	1
;
