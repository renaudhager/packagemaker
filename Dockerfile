FROM ubuntu:14.04

ADD build.sh /app/build.sh
ADD config.params /app/config.params


RUN \
apt-get update && \
apt-get install -y build-essential git ruby-dev rpm wget && \
git clone https://github.com/jordansissel/fpm && \
cd fpm && \
gem install fpm && \
chmod +x /app/build.sh

WORKDIR /app

CMD "/app/build.sh"
