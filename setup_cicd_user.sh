#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

# Install dependencies
apt-get update
apt-get install -y uidmap

# Create user
useradd -m -s /bin/bash cicd

# Install rootless docker
loginctl enable-linger cicd

runuser -l cicd -c 'curl -fsSL https://get.docker.com/rootless -o ~/get-docker.sh'
runuser -l cicd -c 'chmod +x ~/get-docker.sh && XDG_RUNTIME_DIR=/run/user/$(id -u) ~/get-docker.sh'

NEW_PATH="$(runuser -l cicd -c 'echo $PATH')"
NEW_DOCKER_HOST="unix:///run/user/$(id -u cicd)/docker.sock"

runuser -l cicd -c "echo 'export PATH=${NEW_PATH}' | tee -a ~/.bash_profile ~/.bashrc"
runuser -l cicd -c "echo 'export DOCKER_HOST=${NEW_DOCKER_HOST}' | tee -a ~/.bash_profile ~/.bashrc"