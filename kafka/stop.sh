#!/usr/bin/env bash

KAFKA=kafka_2.13-3.0.0
cd $KAFKA
bash bin/kafka-server-stop.sh
bash bin/zookeeper-server-stop.sh

if [ -f "pid.lst" ]; then
    echo "pid.lst found"
    cat pid.lst
    cat pid.lst | xargs -I %% kill -9 %% || echo "process not found"
    rm pid.lst
fi

[ -d "/tmp/kafka-logs" ] && rm -rf /tmp/kafka-logs
[ -d "/tmp/zookeeper" ] && rm -rf  /tmp/zookeeper

timeout 5 tail -f logs/server.log