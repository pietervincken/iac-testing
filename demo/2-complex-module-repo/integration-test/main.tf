module "vpc" {
  source = "../vpc-module"

  env  = "tst"
  name = "integration-test-vpc"
}

module "vm" {
  source = "../ec2-module"

  env  = "tst"
  name = "integration-test-ec2"
  subnet_id = module.vpc.subnet_ids[0]
}

module "alarms" {
  source = "../ec2-default-alarms"
  instance_id = module.vm.instance_id
}
