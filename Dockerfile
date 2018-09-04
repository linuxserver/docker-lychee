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
 git clone https://github.com/LycheeOrg/Lychee /usr/share/webapps/lychee && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /pictures
