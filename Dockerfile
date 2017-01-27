FROM lsiobase/alpine.nginx:3.5
MAINTAINER chbmb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
 	php7-curl \
	php7-exif \
	php7-mysqlnd \
	php7-zip 
	
# install lychee
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \
 curl -o \
 /tmp/lychee.tar.gz -L \
        https://github.com/electerious/Lychee/archive/master.tar.gz && \
mkdir -p \
	/usr/share/webapps/lychee && \
 tar xf \
 /tmp/lychee.tar.gz -C \
        /usr/share/webapps/lychee --strip-components=1 && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
        /tmp/*
	
# symlinks
RUN \
ln -s /usr/share/webapps/lychee/data data  && \
ln -s /usr/share/webapps/lychee/uploads uploads 
	
# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /uploads /data
