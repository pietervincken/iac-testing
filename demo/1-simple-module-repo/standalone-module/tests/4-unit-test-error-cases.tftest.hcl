run "incorrect_env" {

  command = plan

  variables {
    env="incorrectenv"
    name="standalone-module-test"
  }

  expect_failures = [ 
    var.env
  ]
}

run "not_allowed_char_in_name" {

  command = plan

  variables {
    env="tst"
    name="standalone:-module-name-test"
  }

  expect_failures = [ 
    var.name
  ]
}

run "name_too_long" {

  command = plan

  variables {
    env="tst"
    name="standalone-module-name-test-ihrekidarmstadtiuminvestigatorseaborgium-ihrekidarmstadtiuminvestigatorseaborgium"
  }

  expect_failures = [ 
    var.name
  ]
}