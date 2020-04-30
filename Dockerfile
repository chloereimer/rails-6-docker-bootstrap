FROM ruby:2.7

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# -P /dev/null to resolve this issue: https://github.com/docker/compose/issues/1393
# CMD ["rails", "server", "-b", "0.0.0.0", "-P", "/dev/null"]
CMD ["rails", "server", "-b", "0.0.0.0"]