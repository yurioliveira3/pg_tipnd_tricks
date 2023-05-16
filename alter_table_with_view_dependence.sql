CREATE OR REPLACE PROCEDURE public.alter_table_with_view_dependence()
LANGUAGE plpgsql
AS $procedure$
DECLARE 
	DROP_VIEWS TEXT;
	CREATE_VIEWS TEXT;
BEGIN 

	
	SELECT INTO
			DROP_VIEWS, CREATE_VIEWS 
			string_agg('DROP VIEW IF EXISTS ' || dependent_ns.nspname || '.' || dependent_view.relname,'; '), string_agg('CREATE OR REPLACE VIEW ' || dependent_ns.nspname || '.' || dependent_view.relname || ' AS ' || pg_get_viewdef(dependent_view.oid),' ')
	FROM
		 pg_depend
	JOIN pg_rewrite ON pg_depend.objid = pg_rewrite.oid
	JOIN pg_class AS dependent_view ON pg_rewrite.ev_class = dependent_view.oid
	JOIN pg_class AS source_table ON pg_depend.refobjid = source_table.oid
	JOIN pg_attribute ON pg_depend.refobjid = pg_attribute.attrelid	AND pg_depend.refobjsubid = pg_attribute.attnum
	JOIN pg_namespace dependent_ns ON dependent_ns.oid = dependent_view.relnamespace
	JOIN pg_namespace source_ns ON source_ns.oid = source_table.relnamespace
	WHERE
			pg_attribute.attnum > 0
		AND source_table.relname = 'TABLE_NAME' 
	;

	EXECUTE FORMAT(DROP_VIEWS);
	
	EXECUTE 'ALTER TABLE 
			TABLE_NAME
			ALTER COLUMN some_column INT8 NOT NULL';
	
	EXECUTE FORMAT(CREATE_VIEWS);
	
END;
$procedure$
;
		
-- CALL public.alter_table_with_view_dependence();
