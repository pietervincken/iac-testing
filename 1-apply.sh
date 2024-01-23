#!/bin/bash

cd terraform

tofu init -upgrade
tofu apply -auto-approve
tofu output -json > output.json

cd ..

mkdir -p test/
rm test/tf-outputs.tfvars
touch test/tf-outputs.tfvars

jq -c '. | keys[]' --raw-output terraform/output.json | while read key ; do
    value=$(jq -c ".$key.value" terraform/output.json )
    echo "tf_output_$key=$value" >> test/tf-outputs.tfvars
done
