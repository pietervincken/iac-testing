## This should check desired state after deployment based on module outputs. 
## It can be extended to included tests with dependent modules. 

run "minimal" {

  command = apply

  assert {
      condition     = strcontains(module.bucket.name, "integration-test-standalone-module-test")
      error_message = "S3 bucket name doesn't contain the standalone module name"
  }
}

