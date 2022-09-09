#!/bin/bash

# Constants
SAVED_CWD=$(pwd)

# Need name of runner
if  [ -z "$RUNNER_NAME" ]
then
    echo "Error: RUNNER_NAME is empty"
    exit 1
fi

ACTION_RUNNER_ROOT_DIRECTORY="${SAVED_CWD}/${RUNNER_NAME}"

# Check if directory for runner exists
if [ ! -d "${ACTION_RUNNER_ROOT_DIRECTORY}" ] 
then
    echo "Error: Directory for runner '${RUNNER_NAME}' does not exist in current working directory"
    exit 1
fi

# Need RUNNER_TOKEN to remove
if  [ -z "$RUNNER_TOKEN" ]
then
    echo "Error: RUNNER_TOKEN is empty"
    exit 1
fi

# Deregister runner
cd "${ACTION_RUNNER_ROOT_DIRECTORY}"
./config.sh remove --token "${RUNNER_TOKEN}"

# Remove runner directory
cd "${SAVED_CWD}"
rm -rf "${ACTION_RUNNER_ROOT_DIRECTORY}"