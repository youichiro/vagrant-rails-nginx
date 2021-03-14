FROM ruby:2.7.1

RUN apt-get update -qq \
  && apt-get install -y default-mysql-client

WORKDIR /api

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

EXPOSE 3000
ENTRYPOINT ["docker/entrypoint.sh"]
CMD ["rails", "s", "-b", "0.0.0.0"]

