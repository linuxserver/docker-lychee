FROM lsiobase/alpine.nginx:3.5
MAINTAINER chbmb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	curl \
	file \
	g++ \
	gcc \
	imagemagick-dev \
	libtool \
	make \
	php7-dev && \

# install runtime packages
 apk add --no-cache \
	imagemagick \
	mc \
	php7-curl \
	php7-exif \
	php7-gd \
	php7-mbstring \
	php7-mysqlnd \
	php7-session \
	php7-zip \
	re2c && \

# install lychee
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

# install php imagemagick
 mkdir -p \
	/tmp/imagick-src && \
 curl -o \
 /tmp/imagick.tgz -L \
	https://pecl.php.net/get/imagick && \
 tar xf \
 /tmp/imagick.tgz -C \
	/tmp/imagick-src --strip-components=1 && \
 cd /tmp/imagick-src && \
 phpize7 && \
 ./configure \
	--prefix=/usr \
	--with-php-config=/usr/bin/php-config7 && \
 make && \
 make install && \
 echo "extension=imagick.so" > /etc/php7/conf.d/00_imagick.ini && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /pictures
