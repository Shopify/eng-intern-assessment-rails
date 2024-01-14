#!/usr/bin/env bash
# exit on error


bundle install
./bin/rails assets:precompile
./bin/rails assets:clean