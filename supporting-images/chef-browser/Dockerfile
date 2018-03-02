FROM ubuntu:16.04

RUN apt-get update && \
	apt-get install git -y && \
	mkdir -p /opt/app && \
	mkdir -p /etc/chef && \
	cd /opt/app && \
	git clone https://github.com/3ofcoins/chef-browser.git

WORKDIR /opt/app/chef-browser

# nicking a bunch of the following from 3ofcoins/chef-browser/Dockerfile, with
# modifications to work a little better as a goiardi docker component
RUN set -e -x && \
    cp config/docker_apt_preferences /etc/apt/preferences.d/brightbox-ruby-ng && \
    echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main' > /etc/apt/sources.list.d/brightbox-ruby-ng.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C3173AA6 && \
    apt-get update && \
    apt-get install --yes ruby2.2 ruby2.2-dev git build-essential libssl-dev libicu-dev cmake pkg-config python-virtualenv && \
    gem install bundler --no-rdoc --no-ri && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN set -e -x ; \
    bundle install --deployment --without development --binstubs && \
    if [ -d .git ];  then \
        git log -n 1 | tee public/REVISION.txt && \
        rm -rf .git; \
    fi && \
    ln -s config/docker_settings.rb settings.rb && \
    install -d -g www-data -m 1770 var


USER www-data
EXPOSE 9292
ENV TITLE Chef Browser
ENV CHEF_CLIENT_KEY /etc/chef/chef-webui.pem

CMD [ "./bin/rackup", "-o", "0.0.0.0", "-p", "9292", "config.ru" ]
