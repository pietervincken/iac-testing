#!/bin/bash

cd testing

tofu init -upgrade
tofu test -var-file="tf-outputs.tfvars" -json | jq -s > test-report.json



cd ..