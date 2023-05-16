# pg_tipnd_tricks

pg_tipnd_tricks is a small repository that helps you with postgresql demands.

It provides a SQL scripts to increase the performance and improve daily deliveries involving pg.

# Scripts 

- alter_table_with_view_dependence.sql
  - Sometimes we need to carry out the alter table on a table that has views, so this script was created that automatically performs the backup and recreates the view that depends on the table.
  
- database_size.sql
  - Script to get the size of postgresql database.

- lock_view.sql
  - Use of pg_locks to map tables that are locked or in a way with very expensive transactions.

- map_lock_table_type.sql
  - Use of pg_locks to map type of lock.

- map_not_null_columns.sql
  - Map what is the not null columns of a table.

- pk_reference_table.sql
  - Represents all tables that have FK for the table filtered on where.

- table_row_number.sql
  - Number of tuples of certain table.

- table_size.sql
  - Size and relative size of table.

- terminate_process.sql
  - Kill process with PID number.
