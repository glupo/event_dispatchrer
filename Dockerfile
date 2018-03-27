FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /event_dispatcher
WORKDIR /event_dispatcher
COPY Gemfile /event_dispatcher/Gemfile
COPY Gemfile.lock /event_dispatcher/Gemfile.lock
RUN bundle install
COPY . /event_dispatcher
