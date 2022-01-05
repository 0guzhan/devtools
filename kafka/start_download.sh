#!/usr/bin/env bash

KAFKA=kafka_2.13-3.0.0
TARGZ=$KAFKA.tgz
if [ ! -f "$TARGZ" ]; then
    curl https://dlcdn.apache.org/kafka/3.0.0/$TARGZ --output $TARGZ
fi

if [ ! -d "$KAFKA" ]; then
    tar -xvzf $TARGZ
fi

cd $KAFKA
if [ -f "pid.lst" ]; then
    cat pid.lst | xargs -I %% kill -9 %% || echo "process not found"
    rm pid.lst
fi

nohup bash bin/zookeeper-server-start.sh config/zookeeper.properties &
echo $! > pid.lst
nohup bash bin/kafka-server-start.sh config/server.properties &
echo $! >> pid.lst
