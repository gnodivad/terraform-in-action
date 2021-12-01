provider "aws" {
  region  = "ap-southeast-1"
  profile = "tf-user"
}

module "s3backend" {
  source    = "terraform-in-action/s3backend/aws"
  namespace = "team-rocket"
}

output "s3backend_config" {
  value = module.s3backend.config
}
