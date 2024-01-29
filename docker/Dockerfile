FROM ruby:3.2.3

# Additional packages needed for compiling gems
RUN apt-get update -q && \
  apt-get install --assume-yes -q --no-install-recommends \
  build-essential \
  git \
  gpg \
  postgresql-client && \
  apt-get upgrade -y \
  openssh-client

# App location is /app
WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
RUN date -u > BUILD_TIME
