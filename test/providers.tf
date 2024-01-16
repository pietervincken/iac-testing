terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      project = "iac-testing"
      owner   = "pieter.vincken@ordina.be"
    }
  }
}
