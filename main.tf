terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-3"
}

variable "names" {
  type    = list(string)
  default = ["김샛별", "정동환"]
}

module "personal_custom_vpc" {
  for_each = toset(var.names)
  source   = "./custom_vpc"
  env      = "personal_${each.key}"
}
