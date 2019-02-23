FROM lsiobase/alpine.nginx:3.9

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
	jq \
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
 LYCHEE_FILENAME=$(curl -sX GET "https://api.github.com/repos/LycheeOrg/Lychee/releases/latest" \
	| jq -jr '. | .assets[0].name') && \
 mkdir -p \
	/usr/share/webapps/lychee && \
 curl -o \
 /tmp/lychee.zip -L \
	"https://github.com/LycheeOrg/Lychee/releases/download/${LYCHEE_RELEASE}/${LYCHEE_FILENAME}" && \
 unzip /tmp/lychee.zip -d /tmp && \
 cp -R /tmp/Lychee*/. /usr/share/webapps/lychee/ && \
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
