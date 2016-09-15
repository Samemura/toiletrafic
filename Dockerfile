FROM ruby:2.3.1-slim
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev && apt-get clean

# mysql
RUN apt-get install -y mysql-client libmysqlclient-dev && apt-get clean

# postgresql
RUN apt-get install -y libpq-dev && apt-get clean

# App home directory
ENV APP_HOME /usr/src/myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Bundle install
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=4

ADD . $APP_HOME