provider "aws" {
  profile = "tf-user"
  region  = "us-west-2"
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = "terraform-in-action-334308"
  region  = "us-east1"
}

provider "docker" {}
