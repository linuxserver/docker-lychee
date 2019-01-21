FROM lsiobase/alpine.nginx:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
ARG LYCHEE_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	imagemagick \
	mc \
	ffmpeg \
	php7-curl \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-mysqli \
	php7-mysqlnd \
	php7-phar \
	php7-zip \
	re2c && \
 echo "**** install lychee ****" && \
 if [ -z ${LYCHEE_RELEASE+x} ]; then \
	LYCHEE_RELEASE=$(curl -sX GET "https://api.github.com/repos/LycheeOrg/Lychee/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	/usr/share/webapps/lychee && \
 curl -o \
 /tmp/lychee.tar.gz -L \
	"https://github.com/LycheeOrg/Lychee/archive/${LYCHEE_RELEASE}.tar.gz" && \
 tar xf \
 /tmp/lychee.tar.gz -C \
	/usr/share/webapps/lychee --strip-components=1 && \
 echo "**** install  composer ****" && \
 cd /tmp && \
 curl -sS https://getcomposer.org/installer | php && \
 mv /tmp/composer.phar /usr/local/bin/composer && \
 echo "**** install composer dependencies ****" && \
 composer install -d /usr/share/webapps/lychee && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /pictures
