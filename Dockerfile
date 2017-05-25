FROM lsiobase/alpine.nginx:3.6
MAINTAINER chbmb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"


# install packages
RUN \
 apk add --no-cache \
	curl \
	imagemagick \
	mc \
	php7-curl \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-mbstring \
	php7-mysqli \
	php7-mysqlnd \
	php7-zip \
	re2c && \

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
