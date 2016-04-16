
### Log in ml-cassandra to create test keyspace and kv table

```
sudo docker exec -it <containter> /bin/bash  
```
```
CREATE KEYSPACE test WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1 };  
CREATE TABLE test.kv(key text PRIMARY KEY, value int);  

INSERT INTO test.kv(key, value) VALUES ('key1', 1);  
INSERT INTO test.kv(key, value) VALUES ('key2', 2);  

use test;  
describe tables     
select * from kv;  
```

### start the spark container linked with devops_kafka


```
docker run --name spark -it --link ml_cassandra -v /home/autoshift/zhc/cassandra_jars:/usr/local/spark/cassandra_jars sequenceiq/spark:1.6.0 bash
```

#### After login spark, submit the spark job

```
cd /usr/local/spark
cp ./cassandra_jars/*.jar ./lib
cp ./cassandra_jars/log4j.properties /usr/local/spark/conf

spark-shell --jars "lib/cassandra-driver-core-2.2.0-rc3.jar,lib/spark-cassandra-connector_2.10-1.5.0-M2.jar,lib/spark-cassandra-connector-java_2.10-1.5.0-RC1.jar,lib/joda-convert-1.8.1.jar,lib/joda-time-2.1.jar,lib/jsr166e-1.1.0.jar,lib/guava-16.0.1.jar" --conf spark.cassandra.connection.host=ml_cassandra

//spark-shell --packages com.datastax.spark:spark-cassandra-connector_2.10:1.5.0-M3 --conf spark.cassandra.connection.host=ml_cassandra

```
```
import com.datastax.spark.connector._
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.joda.convert.FromString

val rdd = sc.cassandraTable("test", "kv")
println(rdd.count)

println(rdd.map(_.getInt("value")).sum)

val collection = sc.parallelize(Seq(("key7", 7), ("key8", 8)))
collection.saveToCassandra("test", "kv", SomeColumns("key", "value"))

```



