#!/bin/sh
echo "write which environment: \n dev staging production ?"
read STACK
scalingo --app project-api-${STACK} run bundle exec rails c
