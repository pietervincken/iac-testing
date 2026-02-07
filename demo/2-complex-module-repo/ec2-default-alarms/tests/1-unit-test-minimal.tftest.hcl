run "setup_vpc" {
  module {
    source = "../vpc-module"
  }
  variables {
    env="tst"
    name="test-fixture-vpc"
  }
}

run "setup_ec2" {
  module {
    source = "../ec2-module"
  }
  variables {
    env="tst"
    name="test-fixture-ec2"
    subnet_id = run.setup_vpc.subnet_ids[1]
  }
}

run "minimal" {

  command = apply

  variables {
    env="tst"
    name="test-fixture"
    instance_id=run.setup_ec2.instance_id
  }
  assert {
      condition     = try(length(output.ids) == 2 ,false)
      error_message = "Expected 2 CloudWatch alarm IDs to be returned"
  }
}