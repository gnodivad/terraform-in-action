module "aws" {
  source = "terraform-in-action/vm/cloud//modules/aws"
  environment = {
    name             = "AWS"
    background_color = "orange"
  }
}

module "azure" {
  source   = "gnodivad/vm/cloud//modules/azure"
  location = "centralus"
  environment = {
    name             = "Azure"
    background_color = "blue"
  }
}

module "gcp" {
  source = "terraform-in-action/vm/cloud//modules/gcp"
  environment = {
    name             = "GCP"
    background_color = "red"
  }
}

module "loadbalancer" {
  source = "gnodivad/vm/cloud//modules/loadbalancer"
  addresses = [
    module.aws.network_address,
    module.azure.network_address,
    module.gcp.network_address,
  ]
}
