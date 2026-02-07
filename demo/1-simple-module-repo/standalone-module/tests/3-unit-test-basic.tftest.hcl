run "env_test" {

  command = apply

  variables {
    env="dev"
    name="standalone-module-test"
  }

  assert {
      condition     = contains(keys(aws_s3_bucket.this.tags_all), "environment")
      error_message = "S3 bucket environment tag should be set"
  }

  assert {
      condition     = aws_s3_bucket.this.tags_all["environment"] == "dev"
      error_message = "S3 bucket environment tag is not set to 'dev'"
  }

  assert {
      condition     = strcontains(aws_s3_bucket.this.id, "-dev-")
      error_message = "S3 should contain the environment 'dev' in the name"
  }
  
}

run "name_test" {

  command = apply

  variables {
    env="tst"
    name="standalone-module-name-test"
  }

  assert {
      condition     = strcontains(aws_s3_bucket.this.id, "standalone-module-name-test")
      error_message = "S3 bucket name doesn't contain the 'standalone-module-name-test'"
  }
  
  assert {
      condition     = startswith(aws_s3_bucket.this.id, "s3-")
      error_message = "S3 bucket name should start with 's3-'"
  }

  assert {
      condition     = strcontains(output.name, "standalone-module-name-test")
      error_message = "S3 bucket name doesn't contain the standalone module name"
  }
    
  assert {
      condition     = strcontains(output.arn, "standalone-module-name-test")
      error_message = "S3 bucket ARN doesn't contain the standalone module name"
  }
}