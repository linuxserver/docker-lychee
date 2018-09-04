FROM lsiobase/alpine.nginx:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	imagemagick \
	mc \
	php7-curl \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-mysqli \
	php7-mysqlnd \
	php7-zip \
	re2c && \
 echo "**** install lychee ****" && \
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
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /pictures
