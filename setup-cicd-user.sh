#!/bin/bash

# Install dependencies
apt-get update
apt-get install -y uidmap

# Create user
useradd -m -s /bin/bash cicd

# Install rootless docker
loginctl enable-linger cicd

runuser -l cicd -c 'curl -fsSL https://get.docker.com/rootless -o ~/get-docker.sh'
runuser -l cicd -c 'chmod +x ~/get-docker.sh && XDG_RUNTIME_DIR=/run/user/$(id -u) ~/get-docker.sh'
runuser -l cicd -c 'echo "export PATH=/home/cicd/bin:\$PATH" >> ~/.bash_profile'
runuser -l cicd -c 'echo "export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock" >> ~/.bash_profile'