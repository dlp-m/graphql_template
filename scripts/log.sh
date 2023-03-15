#!/bin/sh
echo "write witch environement: \n dev staging production ?"
read STACK
scalingo --region osc-fr1 --app project-api-${STACK} logs --lines 100000
