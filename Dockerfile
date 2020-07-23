FROM ruby:2.7

ENV LANG C.UTF-8
ENV APP_ROOT /opt/app

RUN apt-get update --fix-missing && \
    apt-get install -y \ 
    git

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

RUN gem install bundler
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT
RUN bundle install --jobs=4 --retry=3


