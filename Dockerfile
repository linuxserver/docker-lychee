FROM lsiobase/alpine.nginx
MAINTAINER chbmb

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
 	php5-curl \
	php5-exif \
	php5-gd \
	php5-imagick \
	php5-mysqli \
	php5-mysql \
	php5-zip 
	
# install lychee
RUN \
mkdir -p \
	/usr/share/webapps/lychee && \
git clone \
	https://github.com/electerious/Lychee.git /usr/share/webapps/lychee
	
# symlinks
RUN \
mkdir -p \
	/config/lychee/{data,uploads} && \
ln -s /config/lychee/data /usr/share/webapps/lychee/data && \
ln -s /config/lychee/uploads /usr/share/webapps/lychee/uploads
	
# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config
