# Create a VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "hangaramit_vpc_${var.env}"
  }
}

# Create a Public Subnet
# 퍼블릭 서브넷은 dev일때만 만들어 져야 한다.
resource "aws_subnet" "public_subnet_1" {
  # count 반복분의 특징 0번 반복은 실행이 안된다.
  count             = var.env == "dev" ? 1 : 0
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = local.az_a

  tags = {
    Name = "hangaramit_public_subnet_1_${var.env}"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = local.az_a

  tags = {
    Name = "hangaramit_private_subnet_1_${var.env}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "hangaramit_igw_${var.env}"
  }
}

resource "aws_nat_gateway" "public_net" {
  count             = var.env == "dev" ? 1 : 0
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_1[0].id
}
