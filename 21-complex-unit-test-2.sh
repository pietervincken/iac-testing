#/bin/bash

cd demo/2-complex-module-repo/ec2-default-alarms
tflocal init
ADDITIONAL_TF_OVERRIDE_LOCATIONS=../vpc-module,../ec2-module tflocal test