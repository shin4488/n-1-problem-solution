FROM ruby:3.4.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt-get update -qq && \
    gem install rails -v '7.2.0' && \
    bundle install
