FROM ruby:2.7.1

RUN apt-get update -qq \
  && apt-get install -y default-mysql-client

WORKDIR /api

COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 3000
ENTRYPOINT ["docker/entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]

