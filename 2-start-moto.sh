#!/bin/sh

export TF_CMD=tofu
export AWS_ENDPOINT_URL=http://localhost:4566
export S3_HOSTNAME=localhost
export MWAA_ENDPOINT=localhost
export S3CONTROL=localhost

# if docker is not running, exit with an error
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
else
    echo "Docker is running. Starting moto..."
    
    # S3_IGNORE_SUBDOMAIN_BUCKETNAME=true moto_server -H 0.0.0.0 -p 4566
    docker run --rm -d -p 4566:5000 -e S3_IGNORE_SUBDOMAIN_BUCKETNAME=true --name moto motoserver/moto:5.1.21 -H 0.0.0.0

    source .venv/bin/activate
    tflocal -version

    # cleanup leftover localstack overrides
    find . -name localstack_providers_override.tf -delete -print
fi