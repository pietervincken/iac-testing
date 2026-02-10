run "data" {
  
}

run "create_s3_object" {

  command = apply

  variables {
    bucket = run.data.bucket_name
  }

  module {
    source = "./create-s3-object"
  }
}

run "validate_s3_object" {

  command = apply

  variables {
    bucket = run.data.bucket_name
  }

  module {
    source = "./validate-s3-object"
  }

  assert {
      condition     = data.aws_s3_object.this.server_side_encryption == "AES256"
      error_message = "S3 object is not encrypted with AES256"
  }
}