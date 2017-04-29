FROM debian:wheezy

MAINTAINER CenturyLink Labs <innovationslab@ctl.io>

ENV BUILD_PACKAGES="libcurl4-openssl-dev ruby-dev build-essential" \
    DEV_PACKAGES="zlib1g-dev libxml2-dev libxslt-dev tzdata libyaml-dev " \
    RUBY_PACKAGES="ruby" \
    RAILS_VERSION="3.2.22.5"

RUN \
  apt-get update && \
  apt-get install $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES -y && \
  gem install --no-ri --no-rdoc bundler
  
RUN gem install nokogiri --no-ri --no-rdoc --version 1.6.8.1 -- --use-system-libraries && \
  gem install rails --no-ri --no-rdoc --version "$RAILS_VERSION" && \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \

  # cleanup and settings
  bundle config --global build.nokogiri  "--use-system-libraries" && \
  bundle config --global build.nokogumbo "--use-system-libraries" && \
  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem

EXPOSE 3000
