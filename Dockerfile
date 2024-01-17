FROM ubuntu:jammy

COPY . /app

WORKDIR /app

# Install necessary dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gnupg2 curl git libssl-dev

# Install RVM
RUN gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | bash -s stable \
    && echo 'export PATH=$PATH:/usr/local/rvm/bin' >> ~/.bashrc

ENV PATH=$PATH:/usr/local/rvm/bin

# SHELL ["/bin/bash", "-c"] 

RUN rvm install 3.2.2 \
    && rvm use 3.2.2 --default \
    && echo 'export PATH=$PATH:/usr/local/rvm/rubies/ruby-3.2.2/bin' >> ~/.bashrc

ENV PATH=$PATH:/usr/local/rvm/rubies/ruby-3.2.2/bin

RUN gem install bundler \
    && bundle install

# Install nodejs and npm packages
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && npm install

# Run database migrations
RUN rails db:migrate

EXPOSE 10000

# Command to run on container start
CMD ["rails", "s", "-b", "0.0.0.0", "-p", "10000"]
