#!/bin/bash

curl -u $RE_USERNAME:$RE_PASS -H "Content-type: application/json" \
             -d '{"name": "db", "port": 12000, "memory_size": 1273741824, "replication": false, "eviction_policy": "volatile-lru", "sharding": true, "shards_count": 3, "oss_cluster": '"$OSS_CLUSTER"', "proxy_policy": "all-nodes", "shards_placement": "sparse", "shard_key_regex": [{"regex": ".*\\{(?<tag>.*)\\}.*"},{"regex": "(?<tag>.*)"}]}' \
             -k -X POST https://localhost:9443/v1/bdbs