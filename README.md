### Usage

Build RE cluster with DMC proxy

```shell
./build.sh false
```

Build RE cluster with OSS Cluster API
```shell
./build.sh true
```

All standard RE ports available from your local network:

- `12000 - 12002` - Redis client ports. 12000 corresponds to master node, other corresponds to node-1, node-2.
In DMC mode only 12000 port is available, with OSS Cluster API you can connect to each node.
- `9443 - 9445` - REST  API connections
- `8443 - 8445` - RE Cluster management UI's 