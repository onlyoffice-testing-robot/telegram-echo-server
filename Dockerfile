FROM ruby:2.4.1

RUN apt-get update && \
    apt-get -y install redis-server
COPY . /root/telegram-echo-server
WORKDIR /root/telegram-echo-server
RUN bundle install
EXPOSE 80
CMD bash start.sh