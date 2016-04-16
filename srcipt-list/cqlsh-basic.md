
cat /etc/cassandra/cassandra.yaml

conf/cassandra.yaml: 
	data_file_directories (/var/lib/cassandra/data), 
	commitlog_directory (/var/lib/cassandra/commitlog), and 
	saved_caches_directory (/var/lib/cassandra/saved_caches). 
Make sure these directories exist and can be written to.

cd /var/lib/cassandra/data




************************************
DESCRIBE KEYSPACES;

DESCRIBE TABLES;

CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }; 

CREATE TABLE users (
  user_id int PRIMARY KEY,
  fname text,
  lname text
);

select count(*) from mysimpletable

************************************

nodetool cfstats raw

nodetool flush raw

du -h /var/lib/cassandra/data/raw