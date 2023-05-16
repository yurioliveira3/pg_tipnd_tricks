-- WITH LOCK TYPES
SELECT
	(CASE locktype
	    WHEN 'advisory' 	 THEN 'Waiting to acquire an advisory user lock.'
	    WHEN 'extend' 		 THEN 'Waiting to extend a relation.'
	    WHEN 'frozenid' 	 THEN 'Waiting to update pg_database.datfrozenxid and pg_database.datminmxid.'
	    WHEN 'object' 		 THEN 'Waiting to acquire a lock on a non-relation database object.'
	    WHEN 'page' 		 THEN 'Waiting to acquire a lock on a page of a relation.'
	    WHEN 'relation' 	 THEN 'Waiting to acquire a lock on a relation.'
	    WHEN 'spectoken' 	 THEN 'Waiting to acquire a speculative insertion lock.'
	    WHEN 'transactionid' THEN 'Waiting for a transaction to finish.'
	    WHEN 'tuple' 		 THEN 'Waiting to acquire a lock on a tuple.'
	    WHEN 'userlock' 	 THEN 'Waiting to acquire a user lock.'
	    WHEN 'virtualxid' 	 THEN 'Waiting to acquire a virtual transaction ID lock.'
	ELSE locktype
	END) 			AS locktype,
	db.datname 		AS "database",
	cl.relname 		AS relname
	-- cl.*
FROM
	pg_catalog.pg_locks AS pl
LEFT JOIN 
	pg_catalog.pg_database AS db ON (pl."database" = db."oid")
LEFT JOIN 
	pg_catalog.pg_class AS cl ON (pl.relation  = cl."oid")
LEFT JOIN
	pg_stat_activity AS psa ON pl.pid = psa.pid
ORDER BY 
	psa.query_start;
