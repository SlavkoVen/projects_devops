#!/bin/bash

set -e

sudo docker run -d -p 4444:4444 -p 7900:7900 --shm-size="2g" --restart always selenium/standalone-firefox:4.23.0-20240727

