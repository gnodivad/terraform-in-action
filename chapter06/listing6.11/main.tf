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
}

variable "region" {
  description = "AWS Region"
  type        = string
}

provider "aws" {
  region  = var.region
  profile = "tf-user"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = terraform.workspace
  }
}
