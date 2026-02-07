locals {
    name="orchestration-example"
    env="prd"
}

module "bucket" {
  source = "../1-simple-module-repo/standalone-module"

  name = local.name
  env  = local.env
}

module "vpc" {
  source = "../2-complex-module-repo/vpc-module"

  env  = local.env
  name = local.name

  cidr_block = "10.1.0.0/16"
}

module "vm" {
  source = "../2-complex-module-repo/ec2-module"

  env  = local.env
  name = local.name

  subnet_id = module.vpc.subnet_ids[1]
}

module "vm_alarms" {
  source = "../2-complex-module-repo/ec2-default-alarms"
  instance_id = module.vm.instance_id
}
