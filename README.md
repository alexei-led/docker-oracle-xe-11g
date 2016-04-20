docker-oracle-xe-11g
============================

This repository contains a **Dockerfile** to create a docker container with Oracle Express Edition 11g Release 2 and Ubuntu 14.04 LTS (Trusty)

[![](https://imagelayers.io/badge/pengbai/docker-oracle-xe-11g-r2:latest.svg)](https://imagelayers.io/?images=pengbai/docker-oracle-xe-11g-r2:latest 'Get your own badge on imagelayers.io')

Image on docker hub: [https://hub.docker.com/r/pengbai/docker-oracle-xe-11g-r2/](https://hub.docker.com/r/pengbai/docker-oracle-xe-11g-r2/)

### Description

Pull image:

```
docker pull pengbai/docker-oracle-xe-11g-r2
```
Run with 8080 and 1521 ports opened:

**Note:** It's important to run Oracle XE with >1GB shared memory.

**Example**: Running Oracle XE in `detached` mode with `1521` and `8080` ports opened and `1GB` shared memory:

```
docker run -d --shm-size=1g -p 1521:1521 -p 8080:8080 pengbai/docker-oracle-xe-11g-r2
```
**NEW!** Option: Execute automatically scripts sql when contaner startup:

In folder where you put your ```*.sql``` files for database init from /local-initdb to ```/entrypoint-initdb.d``` in contaner
```
docker run -d -p 8080:8080 -p 1521:1521 -v /local-initdb:/entrypoint-initdb.d pengbai/docker-oracle-xe-11g-r2
```

Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Password for **SYS** user
```
oracle
```

Connect to Oracle Application Express web management console with following settings:
```
url: http://localhost:8080/apex
workspace: internal
user: admin
password: oracle
```

Do not forget to change `admin` password!
