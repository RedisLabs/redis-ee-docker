#!/bin/bash

curl -u $RE_USERNAME:$RE_PASS -H "Content-type: application/json" \
             -d '{
                "name": "db",
                "port": '$RE_DB_PORT',
                "memory_size": 1273741824,
                "replication": false,
                "eviction_policy": "volatile-lru",
                "sharding": true, "shards_count": 3,
                "module_list": [
                    {"module_args": "","module_name": "ReJSON"},
                    {"module_args": "", "module_name": "search"},
                    {"module_args": "", "module_name": "timeseries"},
                    {"module_args": "", "module_name": "redisgears_2"},
                    {"module_args": "", "module_name": "bf"}],
                "oss_cluster": '$RE_USE_OSS_CLUSTER',
                "proxy_policy": "all-nodes",
                "shards_placement": "sparse",
                "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"},{"regex": "(?<tag>.*)"}]}' \
             -k -X POST https://localhost:9443/v1/bdbs
