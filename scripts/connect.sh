#!/bin/sh
echo "write witch environement: \n dev staging production ?"
read STACK
scalingo --app project-api-${STACK} run bundle exec rails c
