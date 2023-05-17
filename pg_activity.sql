SELECT
	pid,
    datname,
    usename,	
    application_name,
    client_addr,
    state,
    wait_event,
    query_start,
 	(EXTRACT(EPOCH FROM (now() - query_start))/60)::decimal(10,2) AS elapsed_time,
    query
FROM
    pg_catalog.pg_stat_activity
WHERE
	      pid <> pg_backend_pid()
    AND state <> 'idle'
ORDER BY 
	9 DESC;