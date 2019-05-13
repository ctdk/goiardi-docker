FROM debian:stretch

RUN set -ex && \
	apt-get update && \
	apt-get install -y \
		git \
		sqitch \
		libdbd-pg-perl \
		postgresql-client \
		libdbd-mysql-perl \
		mysql-client

# Try and remove some of the extraneous junk as best we can -- unfortunately the
# perl libs take up an awful lot of space. At least this image doesn't need to
# be run hardly ever, and Debian actually includes sqitch as a package.
# (Building sqitch from CPAN with the alpine image was constantly blowing up
# all over the place.)
RUN apt-get clean -y && \
	rm -r /usr/share/doc && \
	rm -r /usr/share/man

RUN mkdir -p /src && mkdir -p /supporting-files
COPY postgres-init.sh /supporting-files
COPY alter-postgres.sql /supporting-files
WORKDIR /src
RUN git clone https://github.com/ctdk/goiardi-schema.git && \
	rm -rf /var/cache/apk/*
WORKDIR /src/goiardi-schema

ENTRYPOINT ["/usr/bin/perl", "-de0"]
