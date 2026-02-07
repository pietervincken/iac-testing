data "aws_s3_bucket" "this" {
    bucket = "s3-prd-orchestration-example"
}

output "bucket_name" {
  value = data.aws_s3_bucket.this.id
}
