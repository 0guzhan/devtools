#!/usr/bin/env bash

KAFKA=kafka_2.13-3.0.0

ps aux | grep kafka | awk '{print $2}'

timeout 5 tail -f $KAFKA/logs/server.log