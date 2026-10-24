resource "aws_s3_bucket" "this" {
  bucket = "s3-prd-1st-nested"
}

module "nested_module2" {
  source = "./nested-module2"
}