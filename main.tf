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

# Create a VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "ap-southeast-3a"

  tags = {
    Name = "hangaramit_public_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "ap-southeast-3a"

  tags = {
    Name = "hangaramit_private_subnet_1"
  }
}





