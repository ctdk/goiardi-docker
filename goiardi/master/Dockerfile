FROM golang:1.8-alpine

# Install whatever's in goiardi master right now

RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		git \
		mercurial 
RUN go get -v -d github.com/ctdk/goiardi \
	&& cd /go/src/github.com/ctdk/goiardi \
	&& go install github.com/ctdk/goiardi \
	&& apk del .build-deps

EXPOSE 4545

RUN mkdir -p /var/lib/goiardi/lfs
RUN mkdir /etc/goiardi

COPY goiardi.conf /etc/goiardi/goiardi.conf

ENTRYPOINT [ "/go/bin/goiardi" ]
CMD [ "-c", "/etc/goiardi/goiardi.conf" ]

VOLUME /etc/goiardi
VOLUME /var/lib/goiardi
