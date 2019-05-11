FROM golang:1.12-alpine

# Set GOIARDI_VERSION with --build-arg (e.g. --build-arg GOIARDI_VERSION=0.11.4)
# to build a specific goiardi version. If nothing is specified, it will build
# master.

ARG GOIARDI_VERSION

RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		git \
		mercurial 
RUN go get -v -d github.com/ctdk/goiardi \
	&& cd /go/src/github.com/ctdk/goiardi \
	&& if [ -n $GOIARDI_VERSION ]; then git checkout $GOIARDI_VERSION; fi \
	&& go install github.com/ctdk/goiardi \
	&& apk del .build-deps \
	&& rm -rf /usr/local/go \
	&& rm -rf /go/pkg \
	&& rm -rf /go/src


RUN mkdir -p /var/lib/goiardi/lfs && \
	mkdir -p /etc/goiardi

COPY goiardi.conf /etc/goiardi/goiardi.conf

EXPOSE 4545

ENTRYPOINT [ "/go/bin/goiardi" ]
CMD [ "-c", "/etc/goiardi/goiardi.conf" ]

VOLUME /etc/goiardi
VOLUME /var/lib/goiardi
