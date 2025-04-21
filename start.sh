#!/bin/sh
#Note: Update the file path as per your local path
cd /home/<>/project/elasticsearch-8.4.3/
echo "starting Elasticsearch..."
echo "bin/elasticsearch -d"
bin/elasticsearch -d 
sleep 5
echo "==================Started Elasticsearch=====================" 
cd /home/<>/project/apache-zookeeper-3.8.0-bin/
echo "Starting Zookeeper..."
echo "nohup bin/zkServer.sh start > /dev/null 2>&1 &"
nohup bin/zkServer.sh start > /dev/null 2>&1 &
sleep 20
bin/zkServer.sh status
wait		
echo "=================Started ZooKeeper==========================" 
cd /home/<>/project/kafka_2.13-3.3.1/
echo "Starting Kafka..."
echo "nohup bin/kafka-server-start.sh config/server.properties > /dev/null 2>&1 &"
nohup bin/kafka-server-start.sh config/server.properties > /dev/null 2>&1 &
sleep 5
echo "=================Started Kafka =============================="
cd /home/<>/project/apache-storm-2.4.0/
echo "Starting Storm DRPC..."
echo "nohup bin/storm drpc > /dev/null 2>&1 &"
nohup bin/storm drpc > /dev/null 2>&1 &
sleep 5
echo "=================Started Apache Storm DRPC==========================" 
