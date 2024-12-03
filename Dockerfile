# syntax=docker/dockerfile:1

FROM ghcr.io/sigstore/cosign/cosign:latest AS cosign-bin

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.20

# set version label
ARG BUILD_DATE
ARG VERSION
ARG LYCHEE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hackerman"

RUN --mount=type=bind,from=cosign-bin,source=/ko-app/cosign,target=/usr/local/bin/cosign \
    --mount=type=bind,source=/lychee.pub,target=/config/lychee.pub \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    nodejs \
    npm && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache --upgrade \
    exiftool \
    ffmpeg \
    gd \
    grep \
    imagemagick \
    jpegoptim \
    php83-bcmath \
    php83-dom \
    php83-exif \
    php83-gd \
    php83-intl \
    php83-mysqli \
    php83-pdo_mysql \
    php83-pdo_pgsql \
    php83-pdo_sqlite \
    php83-pecl-imagick \
    php83-pecl-redis \
    php83-pgsql \
    php83-sodium \
    php83-sqlite3 \
    php83-tokenizer \
    postgresql15-client \
    unzip && \
  echo "**** configure php-fpm to pass env vars ****" && \
  sed -E -i 's/^;?clear_env ?=.*$/clear_env = no/g' /etc/php83/php-fpm.d/www.conf && \
  grep -qxF 'clear_env = no' /etc/php83/php-fpm.d/www.conf || echo 'clear_env = no' >> /etc/php83/php-fpm.d/www.conf && \
  echo "**** install lychee ****" && \
  if [ -z "${LYCHEE_VERSION}" ]; then \
    LYCHEE_VERSION=$(curl -sX GET "https://api.github.com/repos/LycheeOrg/Lychee/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/lychee.zip -L \
    "https://github.com/LycheeOrg/Lychee/releases/download/${LYCHEE_VERSION}/Lychee.zip" && \
  curl -o \
    /tmp/lychee.zip.asc -L \
    "https://github.com/LycheeOrg/Lychee/releases/download/${LYCHEE_VERSION}/Lychee.zip.asc" && \
  cosign verify-blob --key /config/lychee.pub --signature /tmp/lychee.zip.asc /tmp/lychee.zip && \
  unzip -q /tmp/lychee.zip -d /app && \
  mv /app/Lychee /app/www && \
  echo "**** install composer dependencies ****" && \
  composer install \
    -d /app/www \
    --no-interaction \
    --no-dev \
    --prefer-dist && \
  echo "**** remove bloat ****" && \
  find . -wholename '*/[Tt]ests/*' -delete && \
  find . -wholename '*/[Tt]est/*' -delete && \
  rm -rf /app/www/storage/framework/cache/data/* && \
  rm -rf /app/www/storage/framework/sessions/* && \
  rm -rf /app/www/storage/framework/views/* && \
  rm -rf /app/www/storage/logs/* && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache \
    $HOME/.composer \
    $HOME/.npm

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
