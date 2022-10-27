locals {
  public_subnets = [for sub_name, v in var.subnets : sub_name if v.public]
}
resource "aws_vpc" "this" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name        = var.environment_name
    Description = "VPC for ${var.environment_name} environment"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = var.environment_name
    Description = "Internet gateway for ${var.environment_name} environment"
  }
}

resource "aws_nat_gateway" "this" {

  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.this[local.public_subnets[0]].id

  tags = {
    Name        = "public-${var.environment_name}"
    Description = "NAT gateway for private subnets"
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "this" {
  vpc = true

  tags = {
    Name        = "nat-gateway"
    Description = "Elastic IP for NAT gateway"
  }
}

