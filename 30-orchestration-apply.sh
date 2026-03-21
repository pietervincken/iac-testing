#/bin/bash

cd demo/3-orchestration-repo
tflocal init -reconfigure
tflocal apply --auto-approve
