terraform {
    backend "s3" {
        bucket = "s3-prd-test"
        key    = "3-orchestration-repo/terraform.tfstate"
        region = "eu-west-1"
        use_lockfile=true
    }
}