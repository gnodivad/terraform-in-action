resource "random_string" "rand" {
  length  = 24
  special = false
  upper   = false
}

locals {
  namespace = substr(join("-", [var.name, random_string.rand.result]), 0, 24)
}

locals {
  projects = ["plan", "apply"]
}

resource "aws_codebuild_project" "project" {
  count        = length(local.projects)
  name         = "${local.namespace}-${local.projects[count.index]}"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "hashicorp/terraform:${var.terraform_version}"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "NO_SOURCE"
    buildspec = file("${path.module}/templates/buildspec_${local.projects[count.index]}.yml")
  }
}

locals {
  backend = templatefile("${path.module}/templates/backend.json", { config : var.s3_backend_config, name : local.namespace })

  default_environment {
    TF_IN_AUTOMATION  = "1"
    TF_INPUT          = "0"
    CONFIRM_DESTROY   = "0"
    WORKING_DIRECTORY = var.working_directory
    BACKEND           = local.backend
  }

  environment = jsonencode([for k, v in merge(local.default_environment, var.environment) : { name : k, value : v, type : "PLAINTEXT" }])
}
