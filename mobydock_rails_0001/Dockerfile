FROM ruby:2.3-slim

# MAINTAINER Nick Janetakis <nick.janetakis@gmail.com>
MAINTAINER Ralph <raybowman2017b@gmail.com>


RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

# RUN :> directive to run shell scripts or shell commands
# -qq :> quiet
# -y :> everything is automated
# build-essential :> make sure that all esential libraries are on the system
#					and compile any native extensions that might be there
# nodejs  :> 
# libpq-dev :> 
# postgresql-client-9.4 :> in case we want to connect to our mobydock container
#		through psql directly


ENV INSTALL_PATH /mobydock
#  set an environment variable for the install path

RUN mkdir -p $INSTALL_PATH
# create the sub-directory without causing an error

WORKDIR $INSTALL_PATH
# WORKDIR :> set the working directory for the docker container
#    all commands after this will be executed within the context of the install path

COPY Gemfile Gemfile
# COPY :> Gemfile from the path within the working container into the image

RUN bundle install
# All gems will be installed within the docker container

COPY . .

# All files are copied from the working directoey to the docker image. Since the Gemfile
# was loaded in a previous operation, it will be cached after the first image generation,
# so it will be installed only once.
# (This is a benefit of the layering system of docker. If you make a change to the app,
# and not to the gemfile, then the COPY and RUN above will not be performed again.)



RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

VOLUME ["$INSTALL_PATH/public"]

CMD bundle exec unicorn -c config/unicorn.rb

# Everything above will be contained within the docker image.
