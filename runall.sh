#!/bin/bash

BASE_PATH="~/data/hidrone"

docker network create hidrone_net

#ETCD
export ETCD_EXTERN_HOST=192.168.80.103
export ETCD_EXTERN_CLIENT_PORT=2379
export ETCD_EXTERN_PATH=$BASE_PATH/etcd/data

mkdir -p $ETCD_EXTERN_PATH && chmod -R 700 $ETCD_EXTERN_PATH
docker-compose -f etcd/docker-compose.yml up -d


#EMQX
docker-compose -f emqx/docker-compose.yml up -d

#Zipkin
docker-compose -f zipkin/docker-compose.yml up -d


#MySql
#mac注释掉storage_env/docker-compose.yml volumes
export MYSQL_MASTER_EXTERN_PORT=23306
export MYSQL_MASTER_EXTERN_PATH=$BASE_PATH/mysql/data/

export REDIS_MASTER_EXTERN_PORT=26379
export REDIS_MASTER_EXTERN_PATH=$BASE_PATH/redis/data

docker-compose -f storage_env/docker-compose.yml up -d


