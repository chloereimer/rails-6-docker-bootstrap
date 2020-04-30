FROM ruby:2.7.1

# configure the yarn repo (rails 6 depends on yarn)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# again, yarn is a rails 6 dependency
RUN apt-get update -qq && apt-get install -y yarn

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install --quiet

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]