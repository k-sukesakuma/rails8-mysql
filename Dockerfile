# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.3.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages and build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    default-mysql-client \
    libjemalloc2 \
    libvips \
    build-essential \
    default-libmysqlclient-dev \
    git \
    libyaml-dev \
    pkg-config \
    make \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# 開発環境用の設定
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_BIN="/usr/local/bundle/bin" \
    PATH="/usr/local/bundle/bin:${PATH}"

# bundle インストール先のディレクトリ権限を設定
RUN mkdir -p /usr/local/bundle && \
    chmod -R 777 /usr/local/bundle

# Copy application code
COPY . .

# Install gems
RUN bundle config set --local path '/usr/local/bundle' && \
    bundle install

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]