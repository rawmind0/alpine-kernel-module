[![](https://images.microbadger.com/badges/image/rawmind/alpine-kernel-module.svg)](https://microbadger.com/images/rawmind/alpine-sysctl "Get your own image badge on microbadger.com")

alpine-kernel-module
=================

A base image to check and load hosts kernel modules. 

## Build

```
docker build -t rawmind/alpine-kernel-module:<version> .
```

## Versions

- `0.1-0` [(Dockerfile)](https://github.com/rawmind0/alpine-kernel-module/blob/0.1-0/Dockerfile).

## Env variables

- LOAD_MODULES=""       # Mandatory: Load kernel modules. Multiple values separted by `,`
- KEEP_ALIVE="0"        # Set to 1 to keep container alive. (to run in k8s)
- KEEP_ALIVE_SLEEP=600  # Sleep time in seconds when keep alive

## Usage

This image basically, upgrade host sysctl key value if it's lower than desired.

```
docker run -t \
  -v /lib/modules:/lib/modules:ro \
  -e "LOAD_MODULES=<MODULE>" \
  --privileged \
  rawmind/alpine-kernel-module:<version> .
```
