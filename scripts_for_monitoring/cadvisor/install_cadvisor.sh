#!/bin/bash

set -e


wget https://github.com/google/cadvisor/releases/download/v0.39.2/cadvisor
cp cadvisor /usr/local/bin
chmod +x /usr/local/bin/cadvisor
