#!/bin/bash -e

# Need RUNNER_TOKEN to configure 1 runner
if  [ -z "$RUNNER_TOKEN" ]
then
    echo "Error: RUNNER_TOKEN is empty"
    exit 1
fi

# Constants
SAVED_CWD=$(pwd)

ACTIONS_INSTALL_FILENAME="actions.tar.gz"
GH_RUNNER_VERSION=${GH_RUNNER_VERSION:-"2.296.1"}
TARGET_ARCH="x64"

ORG_NAME=${ORG_NAME:-"IFS4205-TraceIT"}
GITHUB_URL="https://github.com/"

RUNNER_LABELS=${RUNNER_LABELS:-"self-hosted"}
RUNNER_WORKDIR="_work"

# Generate unique name of runner
RUNNER_NAME=github-runner-$(cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c 32)

# Create directory where files are extracted to
ACTION_RUNNER_ROOT_DIRECTORY="${SAVED_CWD}/${RUNNER_NAME}"
mkdir -p "${ACTION_RUNNER_ROOT_DIRECTORY}"
cd "${ACTION_RUNNER_ROOT_DIRECTORY}"

# Download and extact files
curl -s -o "$ACTIONS_INSTALL_FILENAME" \
    -L "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-${TARGET_ARCH}-${GH_RUNNER_VERSION}.tar.gz" > /dev/null 2>&1
tar -zxf "${ACTIONS_INSTALL_FILENAME}" > /dev/null 2>&1
rm "${ACTIONS_INSTALL_FILENAME}"

# Configure runner
./config.sh \
    --unattended \
    --replace \
    --name "${RUNNER_NAME}" \
    --url "${GITHUB_URL}${ORG_NAME}" \
    --token "${RUNNER_TOKEN}" \
    --runnergroup "Default" \
    --labels "${RUNNER_LABELS}" \
    --work "${RUNNER_WORKDIR}" \
    > /dev/null 2>&1

echo "PATH=${PATH}" >> ./.env
echo "DOCKER_HOST=${DOCKER_HOST}" >> ./.env
    
echo "${RUNNER_NAME}"