variable "vcs_repo" {
  type = object({ identifier = string, branch = string })
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf-user"
}

module "s3backend" {
  source         = "terraform-in-action/s3backend/aws"
  principal_arns = [module.codepipeline.deployment_role_arn]
}

module "codepipeline" {
  source   = "./modules/codepipeline"
  name     = "terraform-in-action"
  vcs_repo = var.vcs_repo

  environment {
    CONFIRM_DESTROY = 1
  }

  deployment_policy = file("./policies/helloworld.json")
  s3_backend_policy = module.s3backend.config
}
