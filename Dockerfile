FROM ruby:3.4.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update -qq && apt-get install -y postgresql-client && gem install rails -v '7.2.0' && bundle install
