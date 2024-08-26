#!/bin/bash

set -e

docker run -p 5050:5050 \
		   --name allure \
           --user="1002:1002" \
		   --restart always \
           -e CHECK_RESULTS_EVERY_SECONDS=3 \
           -e KEEP_HISTORY=1 \
           -v /data/allure-results:/app/allure-results \
           -v /data/allure-reports:/app/default-reports \
           -d frankescobar/allure-docker-service
