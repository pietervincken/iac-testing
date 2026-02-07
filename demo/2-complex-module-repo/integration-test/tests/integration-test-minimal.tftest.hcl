## This should check desired state after deployment based on module outputs. 
## It can be extended to included tests with dependent modules. 

run "minimal" {

  command = apply

  assert {
      condition     = try(module.vm.instance_id !="" ,false)
      error_message = "EC2 instance ID should not be empty"
  }

  assert {
      condition     = try(module.alarms.ids !="" ,false)
      error_message = "Alarms should not be empty"
  }
}

