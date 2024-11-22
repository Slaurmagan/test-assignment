FROM ruby:3.3.0-slim

# Set locale
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

RUN apt-get update -qq \
    && apt-get install -qq -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential \
      wget \
      libpq-dev \
      git \
      tzdata \
      libxml2-dev \
      libxslt-dev \
      shared-mime-info \
      libvips \
      curl \
      gnupg \
      cron \
      ssh && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.yarnpkg.com/debian/pubkey.gpg
RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN cat pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

ENV APP_NAME=/app
RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

COPY Gemfile* $APP_NAME/

ENV BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=3 \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN gem update --system && gem install bundler:2.4
RUN yarn install
RUN bundle install

COPY . /$APP_NAME
