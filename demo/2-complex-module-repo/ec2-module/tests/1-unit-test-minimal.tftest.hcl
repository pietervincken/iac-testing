run "setup_vpc" {
  
  command = apply

  module {
    source = "../vpc-module"
  }
  variables {
    env="tst"
    name="test-fixture-vpc"
  }
}

run "minimal" {

  command = apply

  variables {
    env="tst"
    name="test-fixture"
    subnet_id=run.setup_vpc.subnet_ids[0]
  }

  assert {
      condition     = contains(keys(aws_instance.this.tags_all), "environment")
      error_message = "EC2 environment tag should be set"
  }

  assert {
      condition     = aws_instance.this.tags_all["environment"] == "tst"
      error_message = "EC2 environment tag is not set to 'tst'"
  }

   assert {
      condition     = contains(keys(aws_instance.this.tags_all), "Name")
      error_message = "EC2 Name tag should be set"
  }

  assert {
      condition     = endswith(aws_instance.this.tags_all["Name"], "test-fixture")
      error_message = "EC2 Name tag is not set to 'test-fixture'"
  }

  assert {
      condition     = startswith(aws_instance.this.tags_all["Name"], "ec2-")
      error_message = "EC2 Name tag is not set to 'ec2-'"
  }
  
  assert {
      condition     = try(output.instance_id!="", false)
      error_message = "EC2 instance ID must be set and should be not empty"
  }
}