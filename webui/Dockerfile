FROM ctdk/rails-3.2

RUN apt-get install git -y

RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/ctdk/chef-server-webui.git
WORKDIR /app/chef-server-webui
# RUN git checkout docker-test
RUN bundle install

# This volume needs to be shared between the goiardi docker image and the
# webui one.
VOLUME /etc/goiardi

CMD [ "bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0" ]
