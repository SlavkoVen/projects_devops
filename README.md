**Introduction **
  In this project, I’ve set up a robust CI/CD pipeline. It begins with configuring the environment using CentOS 9 and VirtualBox. GitLab serves as our code management platform. I’ve created a dedicated user, established SSH connections, and cloned repositories. 
  Docker is installed for containerization, and Selenium Grid is configured for distributed testing. The pipelines are executed by GitLab Runner, utilizing CI/CD variables and volumes for flexibility. 
  Allure generates reports within Docker containers, and Telegram alerts keep us informed. 
For monitoring,  integrated Prometheus, Grafana, and exporters, ensuring robust dashboards for resource tracking.

**1 Setting Up the Environment**
- CentOS 9 and VirtualBox (VBox):
  Ensure you have CentOS 9 installed in a VirtualBox VM.
Install VirtualBox Guest Additions for better integration between the host and guest systems.
- Creating a New User:
  Open a terminal as the root user.
  Create a new user named “admin”:	useradd admin
                                    passwd admin
Verify that the user was created:	ls -la /home/cat /etc/passwd

**Granting Sudo Access to the User:**
  Edit the sudoers file (do not directly edit /etc/sudoers):   visudo
  Add the following line to allow the user “admin” to use sudo: admin ALL=(ALL:ALL) ALL
**Shared Folder Setup**
  - Creating a Shared Folder:
  In VirtualBox, create a shared folder (let’s call it “shared_folder”) that will be accessible from both the virtual machine and the host system.

  - Mounting the Shared Folder:
  Inside the CentOS VM, create a mount point:  sudo mkdir /cdrom
  Mount the VirtualBox Guest Additions CD (assuming it’s already inserted):  sudo mount /dev/cdrom /cdrom/

Run the installation script:			/cdrom/VBoxLinuxAdditions.run
Making the Mount Permanent:
To ensure the shared folder is mounted automatically on boot, add an entry to /etc/fstab:			shared /home/admin/shared_folder vboxsf auto,no-fail,rw 0 0
SSH, Gitlab, and Git
SSH Key Setup:
Generate an SSH key pair for the user “admin”:	ssh-keygen -t rsa
Copy the public key (id_rsa.pub) to Gitlab for authentication.
Git Clone:
Navigate to the directory where you want to clone your Git project.
Clone the repository using SSH:		git clone git@github.com:directino/to/file.git

Docker and Infrastructure as Code
Docker Installation:
Install Docker on CentOS:		sudo yum install docker
Start the Docker service:		sudo systemctl start docker

Basic Docker Commands:
View running containers:		sudo docker ps -a
View available images: 		sudo docker images
Run a container:			sudo docker run <image_name>
Stop all containers			sudo docker stop $(sudo docker ps -a -q)
Start a stopped container:		sudo docker start <container_id>
Remove a container:			sudo docker rm <container_id>
Remove an image:			sudo docker rmi <image_id>

Building Docker Images:
Build an image from a Dockerfile (use -t to tag it):	sudo docker build --no-cache -t test .
Running Containers:
Run a container in the background:	sudo docker run --name super -d test:latest
View container logs:			sudo docker logs super

Execute commands inside a running container: 	sudo docker exec -it super bash
Running a Docker Container
Dockerfile Basics:
A Dockerfile is a text document that contains instructions for building a Docker image.
Key instructions include:
FROM: Specifies the base image.
RUN: Executes commands during image build (e.g., installing packages).
CMD: Defines the default command to run when the container starts.
COPY and ADD: Copy files into the image.
ENV: Sets environment variables.
EXPOSE: Describes which ports the application listens on.

GitLab Runner Configuration:
Install GitLab Runner on your machine.
Configure GitLab Runner settings using the config.toml file.
Ensure GitLab Runner has the necessary permissions (e.g., Docker access).
Add GitLab Runner to the Docker group (important for Docker access).

.gitlab-ci.yml Configuration:
The .gitlab-ci.yml file defines your CI/CD pipeline.
It specifies jobs, stages, and other parameters.
YAML syntax is used to structure the pipeline.
Examples of configuration options:
stages: Define the execution order of jobs.
jobs: Describe individual tasks (e.g., testing, building, deploying).
before_script and after_script: Execute commands before and after jobs.
variables: Set environment variables.
cache: Define caching paths for dependencies.
script: Specify the actual commands to run in each job.

Handling Branch Conflicts:
To avoid conflicts between local and remote branches:
Pull the latest changes from the remote branch (git pull origin main).
Fetch updates (git fetch origin main).
Merge changes (git merge origin/main).
Finally, push your changes (git push origin main).
:
Setting Up CI/CD Variables and Volumes
.gitlab-ci.yml Configuration:
The .gitlab-ci.yml file defines your CI/CD pipeline in GitLab.
It specifies stages, jobs, and other parameters.
Key concepts include:
stages: Define the execution order of jobs (e.g., “build,” “test,” “deploy”).
before_script and after_script: Commands executed before and after each job.
script: The main command to run in each job.
variables: Define environment variables.
artifacts: Specify files to keep after job execution.
cache: Configure caching for faster builds.
only and except: Control when jobs run based on conditions (e.g., specific branches or tags).

Creating Directories and Managing Permissions:
Create directories for storing reports (e.g., /data, /data/allure-results, /data/allure-reports).
Ensure that the gitlab-runner user has appropriate permissions (use chown to set ownership)

Mounting Volumes in Docker:
Volumes are a preferred mechanism for persisting data generated by and used by Docker containers.
Unlike bind mounts, volumes are managed entirely by Docker.
Advantages of volumes:
Easier to back up or migrate.
Managed via Docker CLI or API.
Compatible with both Linux and Windows containers.
Safely shared among multiple containers.

Allure Reports with Docker:
Use the Allure Docker Service to generate Allure reports.
When creating a container with Allure, specify the user (e.g., GitLab Runner) using the --user option.
To view the ID of GitLab Runner, check /etc/passwd.

Docker Run Parameters:
When running a container, use parameters like -v (volume), -e (environment variables), and -d (detached mode).
For port mapping, use -p (e.g., -p 5050:5050 to map port 5050 on the host to the container).
Example: sudo docker container run -p 5050:5050 [image_name].

Alerting via Telegram:
The curl command you provided is used to send a message to a Telegram chat using the Telegram Bot API.
It sends a silent POST request to the specified Telegram endpoint with the chat ID and the message text.
The variables ${TELEGRAM_TOKEN}, ${CHAT_ID}, ${REPORT_DATE}, ${MAIN_HOST}, and ${ALLURE_PORT} should be replaced with actual values in your script.

Monitoring with Prometheus and Grafana:
Prometheus is an open-source monitoring system designed for microservices and containers.
It collects and stores metrics as time series data.
Grafana, also open-source, provides visualization and dashboards for monitoring.
You can create Grafana dashboards to display system metrics from a server monitored by Prometheus.
Grafana allows integration with various data sources (e.g., Prometheus, Elasticsearch, MySQL, PostgreSQL).

Common Grafana Metric Types:
Response Time: Average time for the server to respond to a request.
CPU Usage: Percentage of computational power used by the processor.
Memory Usage: Percentage of RAM utilization.
Network Traffic: Data transfer volume over the network.

Edit Prometheus Configuration:
Open the Prometheus configuration file (prometheus.yml) using your preferred text editor (e.g., sudo nano /etc/prometheus/prometheus.yml).
Add the necessary configurations for Node Exporter and cAdvisor.
# Alertmanager configurations
alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093

# Node Exporter configuration
- job_name: "node_exporter"
  static_configs:
    - targets: ["localhost:9100"]

# cAdvisor configuration
- job_name: "cadvisor"
  static_configs:
    - targets: ["localhost:8080"]


Restart Prometheus:
After editing the configuration, restart the Prometheus service:
				sudo systemctl restart prometheus.service



