FROM golang:1.8-alpine

RUN set -ex && \
	apk add --no-cache --virtual .build-deps \
		git \
		mercurial
RUN go get -v -u github.com/raintank/statsdaemon/cmd/statsdaemon && \
	apk del .build-deps

COPY statsdaemon.ini /etc/statsdaemon.ini

EXPOSE 8125/udp
EXPOSE 8126

ENTRYPOINT [ "/go/bin/statsdaemon" ]
