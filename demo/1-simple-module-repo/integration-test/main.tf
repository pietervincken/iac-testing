module "bucket" {
  source = "../standalone-module"

  env  = "tst"
  name = "integration-test-standalone-module-test"

}