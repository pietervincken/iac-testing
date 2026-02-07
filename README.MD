# Demo repository for testing Terraform / OpenTofu IaC test

## How to run using localstack 

### Prerequisits

- Local docker runtime (Rancher, Docker Desktop, ...). The demo is built for Rancher based on [this](https://docs.localstack.cloud/aws/integrations/containers/rancher-desktop/)
- OpenTofu binary (or Hashicorp Terraform).
- Python3

### How to use

Run `source 1-install-localstack.sh`. This will create a python virtualenv and install the necessary tools (tf-local). You'll only have to run this once. 

Run `source 2-start-localstack.sh`. This will start localstack and make sure the virtualenv is enabled to allow for the tf-local binary to be found. You'll have to run this every time you use the demo. 

Use the other test scripts to run the different scenarios. 

Run `source 99-stop-localstack.sh`. This undoes what 101 did. It stops the localstack container and deactivates the virtualenv. 