#/bin/bash

cd demo/3-orchestration-repo
tflocal init
ADDITIONAL_TF_OVERRIDE_LOCATIONS=./tests/validate-instance,./tests/create-s3-object,./tests/validate-s3-object tflocal test