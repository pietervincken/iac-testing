#!/bin/sh

export TF_CMD=tofu

# if docker is not running, exit with an error
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
else
    echo "Docker is running. Starting LocalStack..."
    
    localstack start --network rancher -d
    source .venv/bin/activate
    tflocal -version

    # cleanup leftover localstack overrides
    find . -name localstack_providers_override.tf -delete -print
fi