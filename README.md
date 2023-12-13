## Usage ##

### Set environment variables ##
Example set of env variables required for cluster setup stored in `.env.example`.
Use it to create your own `.env`

```shell
cp .env.example .env
```

If you're using a custom docker image in the private repo, please set values in 
`.env.credentials` and export them

```shell
export $(cat .env.credentials | xargs)
```

### Build RE cluster ###
By default, RE cluster supports single endpoint and relies on DMC proxy to calculate hash slot.
Multiple endpoints (OSS cluster mode) could be enabled by setting env variable `OSS_CLUSTER=true`.

All standard RE ports available from your local network:

- `12000 - 12002` - Redis client ports. 12000 corresponds to master node, other corresponds to node-1, node-2.
In DMC mode only 12000 port is available, with OSS Cluster API you can connect to each node.
- `6372-6374, 6379` - Additional ports accessible from local network.
- `9443 - 9445` - REST  API connections
- `8443 - 8445` - RE Cluster management UI's 