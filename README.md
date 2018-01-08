[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://lychee.electerious.com/
[hub]: https://hub.docker.com/r/linuxserver/lychee/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/lychee
[![](https://images.microbadger.com/badges/version/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/lychee.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/lychee.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-lychee)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-lychee/)

Lychee is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.


[![lychee](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/lychee-icon.png)][appurl]

## Usage

```
docker create \
  --name=lychee \
  -v <path to data>:/config \
  -v <path to data>:/pictures \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 80:80 \
  linuxserver/lychee
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 80` - the port(s)
* `-v /config` - config files for lychee
* `-v /pictures` - where lychee will store uploaded data
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it lychee /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Setup mysql/mariadb and account via the webui, more info at [lychee][appurl].

## Info

* Shell access whilst the container is running: `docker exec -it lychee /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f lychee`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' lychee`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/lychee`

## Versions

+ **08.01.18:** Rebase to alpine 3.7.
+ **25.05.17:** Rebase to alpine 3.6.
+ **03.05.17:** Use repo pinning to better solve dependencies, use repo version of php7-imagick.
+ **12.02.17:** Initial Release.
