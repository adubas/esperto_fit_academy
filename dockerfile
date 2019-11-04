FROM ruby:2.6.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

RUN mkdir /esperto_fit_academy
WORKDIR /esperto_fit_academy
COPY Gemfile* /esperto_fit_academy/
RUN bundle install
COPY . /esperto_fit_academy

CMD ["rails", "server", "-b", "0.0.0.0"]