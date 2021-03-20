FROM ruby:2.7.1-slim-buster

RUN apt-get update \
  && apt-get install -y default-mysql-client \
  libmariadb-dev \
  build-essential \
  vim \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /api

COPY Gemfile Gemfile.lock ./
RUN bundle config set path vendor/bundle
RUN gem install bundler:2.2.14
RUN bundle install

ENTRYPOINT ["docker/entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]
