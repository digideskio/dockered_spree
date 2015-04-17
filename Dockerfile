FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim

RUN mkdir /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
#RUN bundle install
RUN mkdir -p /var/bundle
ADD vendor/cache /myapp/vendor/cache
RUN cd /myapp && bundle install --deployment --path /var/bundle --without development test

ADD . /myapp
WORKDIR /myapp
#RUN bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]
