[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/lychee](https://github.com/linuxserver/docker-lychee)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/lychee.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/lychee.svg)

[Lychee](https://lychee.electerious.com/) is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.

[![lychee](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/lychee-icon.png)](https://lychee.electerious.com/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=lychee \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v </path/to/appdata/config>:/config \
  -v </path/to/pictures>:/pictures \
  --restart unless-stopped \
  linuxserver/lychee
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  lychee:
    image: linuxserver/lychee
    container_name: lychee
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
      - </path/to/pictures>:/pictures
    ports:
      - 80:80
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http gui |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Contains all relevant configuration files. |
| `-v /pictures` | Where lychee will store uploaded data. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;
## Application Setup

Setup mysql/mariadb and account via the webui, accessible at http://SERVERIP:PORT  
More info at [lychee](https://lychee.electerious.com/).  



## Support Info

* Shell access whilst the container is running: `docker exec -it lychee /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f lychee`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' lychee`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/lychee`

## Versions

* **16.01.18:** - Switch to dynamic readme.
* **14.01.19:** - Adding pipeline logic and multi arch..
* **04.09.18:** - Rebase to alpine 3.8, switch to LycheeOrg repository.
* **08.01.18:** - Rebase to alpine 3.7.
* **25.05.17:** - Rebase to alpine 3.6.
* **03.05.17:** - Use repo pinning to better solve dependencies, use repo version of php7-imagick.
* **12.02.17:** - Initial Release.
