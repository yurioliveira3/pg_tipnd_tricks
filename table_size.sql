SELECT
	schema_name,
    relname table_name,
    reltuples AS tuples,
    pg_size_pretty(table_size) AS pretty_size,
    table_size AS bytes_size
FROM (
		 SELECT
		  	pg_catalog.pg_namespace.nspname           AS schema_name,
		  	relname,
		  	reltuples,
		  	pg_relation_size(pg_catalog.pg_class.oid) AS table_size
		FROM 
			pg_catalog.pg_class 
		JOIN 
			pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
		WHERE 
			nspname = 'SCHEMA_NAME'
			AND relkind = 'r'
 	) 	AS t
-- WHERE
-- 	schema_name = 'public'
ORDER BY
	table_size DESC;