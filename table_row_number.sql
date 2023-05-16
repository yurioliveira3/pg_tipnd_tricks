SELECT 
    nspname   AS "schema",
    relname   AS "table",
    reltuples AS "tuples"
FROM 
	pg_class C
LEFT JOIN 
	pg_namespace N ON (N."oid" = C.relnamespace)
WHERE 
  	nspname = 'SCHEMA_NAME'  
  	AND relkind='r'
  	AND reltuples > 0
ORDER BY 
	reltuples DESC
;
