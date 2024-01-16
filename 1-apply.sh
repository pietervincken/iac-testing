#!/bin/bash

cd terraform

tofu init -upgrade
tofu apply -auto-approve
tofu output -json > output.json

cd ..

rm testing/tf-outputs.tfvars

jq -c '. | keys[]' --raw-output terraform/output.json | while read key ; do
    value=$(jq -c ".$key.value" terraform/output.json )
    echo "tf_output_$key=$value" >> testing/tf-outputs.tfvars
done
