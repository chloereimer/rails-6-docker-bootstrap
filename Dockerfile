FROM ruby:2.7

# configure the yarn repo (rails 6 depends on yarn)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# again, yarn is a rails 6 dependency
RUN apt-get update -qq && apt-get install -y yarn

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# -P /dev/null to resolve this issue: https://github.com/docker/compose/issues/1393
# CMD ["rails", "server", "-b", "0.0.0.0", "-P", "/dev/null"]
CMD ["rails", "server", "-b", "0.0.0.0"]