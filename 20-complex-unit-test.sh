#/bin/bash

cd demo/2-complex-module-repo/ec2-module
tflocal init
ADDITIONAL_TF_OVERRIDE_LOCATIONS=../vpc-module tflocal test