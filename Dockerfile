FROM lsiobase/alpine.nginx:3.5
MAINTAINER chbmb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# add repositories
RUN \
 echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
 echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \

# install packages
 apk add --no-cache \
	curl \
	mc \
	re2c && \
 apk add --no-cache \
	imagemagick@edge \
	libwebp@edge && \
 apk add --no-cache \
	php7-curl@community \
	php7-exif@community \
	php7-gd@community \
	php7-imagick@community \
	php7-mbstring@community \
	php7-mysqli@community \
	php7-mysqlnd@community \
	php7-zip@community && \

# install lychee
 mkdir -p \
	/usr/share/webapps/lychee && \
 lychee_tag=$(curl -sX GET "https://api.github.com/repos/electerious/Lychee/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/lychee.tar.gz -L \
	"https://github.com/electerious/Lychee/archive/${lychee_tag}.tar.gz" && \
 tar xf \
 /tmp/lychee.tar.gz -C \
	/usr/share/webapps/lychee --strip-components=1 && \

# cleanup
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /pictures
