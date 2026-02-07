run "orchestration_test" {

  command = apply

  assert {
      condition     = strcontains(module.bucket.name, "s3-prd-orchestration")
      error_message = "S3 bucket name doesn't contain the 's3-prd-orchestration' name"
  }
}

run "validate_instance" {

  command = apply

  variables {
    instance_id = run.orchestration_test.vm_instance_id
  }

  module {
    source = "./tests/validate-instance"
  }

  assert {
      # https://docs.aws.amazon.com/vpc/latest/userguide/subnet-sizing.html#subnet-sizing-ipv4
      # 0 = network address, 1 = vpc router, 2 = DNS, 3 = reserved for AWS future use, 4 = first free IP.
      # second subnet /24 subnet in the 10.1.0.0/16 is used which is 10.1.1.0/24
      condition     = data.aws_instance.this.private_ip == "10.1.1.4"
      error_message = "EC2 instance private IP is not '10.1.1.4'"
  }
}

run "create_s3_object" {

  command = apply

  variables {
    bucket = run.orchestration_test.bucket
  }

  module {
    source = "./tests/create-s3-object"
  }
}

run "validate_s3_object" {

  command = apply

  variables {
    bucket = run.orchestration_test.bucket
  }

  module {
    source = "./tests/validate-s3-object"
  }

  assert {
      condition     = data.aws_s3_object.this.server_side_encryption == "AES256"
      error_message = "S3 object is not encrypted with AES256"
  }
}