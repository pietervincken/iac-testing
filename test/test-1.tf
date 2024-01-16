
variable "tf_output_bucket_name" {
  description = "name of the bucket to be tested"
}

data "aws_s3_bucket" "this" {
  bucket = var.tf_output_bucket_name
}

