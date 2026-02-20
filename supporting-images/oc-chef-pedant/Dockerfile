FROM base2/chefdk:3.13.1

RUN sudo apt-get install git -y

RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/ctdk/oc-chef-pedant.git
WORKDIR /app/oc-chef-pedant
COPY pedant_config.rb /app/oc-chef-pedant/pedant_config.rb
COPY multitenant_config.rb /app/oc-chef-pedant/multitenant_config.rb
RUN bundle install

# Needs to be shared with the goiardi docker image. This makes things a bit
# easier, at least.

VOLUME /etc/goiardi

CMD [ "tail", "-f", "/dev/null" ]
