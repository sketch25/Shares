FROM ruby:2.6.5

RUN apt-get update && \
    apt-get install -y mariadb-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /shares

WORKDIR /shares

ADD Gemfile /shares/Gemfile
ADD Gemfile.lock /shares/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /shares

RUN mkdir tmp/pids
RUN mkdir -p tmp/sockets