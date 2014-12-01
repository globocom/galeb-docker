#!/bin/bash

BASE_PATH=/opt/galeb/

export CLASSPATH=$BASE_PATH/galeb-router/target/classes:$BASE_PATH/galeb-log4j2/target/classes:$(cat /tmp/_classpath)

JVM_OPTS="-Dvertx.clusterManagerFactory=org.vertx.java.spi.cluster.impl.hazelcast.HazelcastClusterManagerFactory
          -Dhazelcast.config=$BASE_PATH/cluster.xml
          -Dhazelcast.logging.class=com.globo.galeb.vertx.log4j2.Log4j2Factory
          -Dorg.vertx.logger-delegate-factory-class-name=com.globo.galeb.vertx.log4j2.Log4j2LogDelegateFactory
          -Dlog4j.configurationFile=$BASE_PATH/log4j.xml"

java $JVM_OPTS org.vertx.java.platform.impl.cli.Starter run com.globo.galeb.verticles.Starter -cluster -conf $BASE_PATH/config.json
