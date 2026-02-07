run "minimal" {

  command = apply

  variables {
    env="tst"
    name="test-fixture"
  }

  assert {
      condition     = contains(keys(aws_vpc.this.tags_all), "environment")
      error_message = "VPC environment tag should be set"
  }

  assert {
      condition     = aws_vpc.this.tags_all["environment"] == "tst"
      error_message = "VPC environment tag is not set to 'tst'"
  }

   assert {
      condition     = contains(keys(aws_vpc.this.tags_all), "Name")
      error_message = "VPC Name tag should be set"
  }

  assert {
      condition     = endswith(aws_vpc.this.tags_all["Name"], "test-fixture")
      error_message = "VPC Name tag is not set to 'test-fixture'"
  }

  assert {
      condition     = startswith(aws_vpc.this.tags_all["Name"], "vpc-")
      error_message = "VPC Name tag is not set to 'vpc-'"
  }
  
  assert {
      condition     = try(output.vpc_id!="", false)
      error_message = "VPC ID must be set and should be not empty"
  }

    assert {
        condition     = try(length(output.subnet_ids) > 0, false)
        error_message = "Subnet IDs output must be set and contain values"
    }

    assert {
        condition     = length(output.subnet_ids) == var.subnet_count
        error_message = "Subnet IDs output length does not match the requested number of subnets"
    }

    assert {
        condition     = "10.0.0.0/24" == local.subnet_cidrs[0]
        error_message = "Calculated subnet CIDR is not as expected. Should be 10.0.0.0/24"
    }

    assert {
        condition     = "10.0.1.0/24" == local.subnet_cidrs[1]
        error_message = "Calculated subnet CIDR is not as expected. Should be 10.0.1.0/24"
    }
}