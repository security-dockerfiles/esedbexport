FROM alpine:latest
LABEL maintainer "ilya@ilyaglotov.com"

ENV LIBUNA_VERSION 20170825
ENV LIBESEDB_VERSION 20120102

RUN apk update \
  && apk add --virtual .deps build-base \
                             ca-certificates \
                             curl \
  && update-ca-certificates \
  \
  # Install libuna (because libesedb won't install with local one smh)
  && curl -sLo /libuna.tar.gz https://github.com/libyal/libuna/releases/download/${LIBUNA_VERSION}/libuna-alpha-${LIBUNA_VERSION}.tar.gz \
  && tar xf /libuna.tar.gz \
  && cd /libuna-${LIBUNA_VERSION} \
  && ./configure \
  && make \
  && make install \
  && cd / \
  && rm -rf /libuna* \
  \
  # Install libesedb
  && curl -sLo /libesedb.tar.gz http://pkgs.fedoraproject.org/repo/pkgs/libesedb/libesedb-alpha-${LIBESEDB_VERSION}.tar.gz/198a30c98ca1b3cb46d10a12bef8deaf/libesedb-alpha-${LIBESEDB_VERSION}.tar.gz \
  && tar xf /libesedb.tar.gz \
  && cd /libesedb-${LIBESEDB_VERSION} \
  && ./configure \
  && make \
  && make install \
  && cd / \
  && rm -rf /libesedb* \
  \
  # Clean up
  && apk del .deps \
  && rm -rf /var/cache/apk/* \
  \
  # Add regular user
  && adduser -D esedb

VOLUME /data

USER esedb

ENTRYPOINT ["esedbexport"]
