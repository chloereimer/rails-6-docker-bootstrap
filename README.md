# README

## How I Built This Dang Repo

1. Took the following Dockerfile from the Ruby image on Dockerhub:
```
FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["./your-daemon-or-script.rb"]
```
2. Changed `FROM` to `ruby:2.7` because Why Not
3. Changed `CMD` to `["rails", "server", "-b", "0.0.0.0"]`
4. Per instructions on Ruby image on Dockerhub, created a simple `Gemfile` with `ruby '~>2.7'` and `gem 'rails', '~>6.0'`
5. Also per those instructions, generated `Gemfile.lock` with:
```
$ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.5 bundle install
```
6. Built the image:
```
$ docker build -t rails6docker .
```
7. Tested the image (expected to see `rails` usage error from calling `rails server` since the app doesn't exist yet, and indeed that's what i saw):
```
$ docker run --rm --name rails6docker rails6docker
```
8. initial commit lol


## Updating Gemfile.lock
From [Chris Blunt](https://www.chrisblunt.com/rails-on-docker-quickly-create-or-update-your-gemfile-lock/):

> Use the following command in your app’s path to quickly create your Gemfile.lock:
> 
> ```
> $ docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:2.3.1 bundle lock
> ```
>
> If you have an existing lock file, but want to update the gems (equivalent to bundle update), just add the --update flag:
> ```
> $ docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:2.3.1 bundle lock --update
> ```