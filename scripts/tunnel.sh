#!/bin/sh
echo "write witch environement: \n dev staging production ?"
read STACK
eval $(scalingo --app project-api-${STACK} env | grep SCALINGO_POSTGRESQL_URL)
echo $SCALINGO_POSTGRESQL_URL
scalingo --app project-api-${STACK} db-tunnel SCALINGO_POSTGRESQL_URL -i $HOME/.ssh/id_rsa
