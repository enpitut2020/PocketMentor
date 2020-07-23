FROM ruby:2.7

ENV LANG C.UTF-8

RUN apt-get update --fix-missing && \
    apt-get install -y

RUN mkdir -p ./working
