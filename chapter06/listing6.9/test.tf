terraform {
  backend "s3" {
    bucket         = "team-rocket-8hojxdn942ki-state-bucket"
    key            = "jesse/james"
    region         = "ap-southeast-1"
    profile        = "tf-user"
    encrypt        = true
    role_arn       = "arn:aws:iam::929917414707:role/team-rocket-8hojxdn942ki-tf-assume-role"
    dynamodb_table = "team-rocket-8hojxdn942ki-state-lock"
  }
  required_version = ">= 0.15"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}
