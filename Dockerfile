FROM ruby:2.7.3

MAINTAINER jonathanoliveirasilva9@gmail.com

ADD . /var/www/app/current
WORKDIR /var/www/app/current

RUN bundle install
CMD /bin/bash