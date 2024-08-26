#!/bin/bash

set -e

sudo curl -L --output /usr/local/bin/gitlab-runner https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-linux-amd64

sudo chmod +x /usr/local/bin/gitlab-runner

sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start	



sudo gitlab-runner register  
--url https://gitlab.com  
--token glrt-fgkCf4fR-pQybLK5sFSi



sudo gitlab-runner run

