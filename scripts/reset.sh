#!/bin/sh
bundle exec rails db:drop db:create db:migrate db:seed
