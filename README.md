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

# [linuxserver/lychee](https://github.com/linuxserver/docker-lychee)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/lychee.svg)](https://microbadger.com/images/linuxserver/lychee "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/lychee.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/lychee.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-lychee/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-lychee/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/lychee/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/lychee/latest/index.html)

[Lychee](https://lychee.electerious.com/) is a free photo-management tool, which runs on your server or web-space. Installing is a matter of seconds. Upload, manage and share photos like from a native application. Lychee comes with everything you need and all your photos are stored securely.

[![lychee](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/lychee-icon.png)](https://lychee.electerious.com/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/lychee` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

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
  -e PUID=1000 \
  -e PGID=1000 \
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
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
      - </path/to/pictures>:/pictures
    ports:
      - 80:80
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http gui |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Contains all relevant configuration files. |
| `-v /pictures` | Where lychee will store uploaded data. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Set up mysql/mariadb and account via the webui, accessible at http://SERVERIP:PORT  
You can change the php upload limits by editing the file `/config/lychee/user.ini` and restarting the container.  
More info at [lychee](https://lychee.electerious.com/).  



## Support Info

* Shell access whilst the container is running: `docker exec -it lychee /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f lychee`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' lychee`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/lychee`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/lychee`
* Stop the running container: `docker stop lychee`
* Delete the container: `docker rm lychee`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start lychee`
* You can also remove the old dangling images: `docker image prune`

### Via Taisun auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one shot:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock taisun/updater \
  --oneshot lychee
  ```
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull lychee`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d lychee`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **22.02.19:** - Rebasing to alpine 3.9.
* **21.02.19:** - Add info on changing php upload limits to readme.
* **21.01.18:** - Added ffmpeg for video thumbnail creation, switched to installing zip release instead of source tarball, created small thumbnails folder, switched to dynamic readme.
* **14.01.19:** - Adding pipeline logic and multi arch..
* **04.09.18:** - Rebase to alpine 3.8, switch to LycheeOrg repository.
* **08.01.18:** - Rebase to alpine 3.7.
* **25.05.17:** - Rebase to alpine 3.6.
* **03.05.17:** - Use repo pinning to better solve dependencies, use repo version of php7-imagick.
* **12.02.17:** - Initial Release.
