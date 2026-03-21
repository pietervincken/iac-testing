#/bin/bash

cd demo/3-orchestration-repo/end-to-end-tests
ADDITIONAL_TF_OVERRIDE_LOCATIONS=./create-s3-object,./validate-s3-object tflocal test