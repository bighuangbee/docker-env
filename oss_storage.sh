#!/bin/sh

#OSS storage
base_path="~/docker_data/hidrone/minio"

export MINIO_EXTERN_PATH=$base_path/data
export MINIO_EXTERN_CONFIG=$base_path/config
export MINIO_EXTERN_CACHE=$base_path/resizer_cache


chmod 755 minio_resizer/run.sh

docker-compose -f minio_resizer/docker-compose.yml up -d
