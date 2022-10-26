resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "default"
    Description = "Default route table for ${var.environment_name} environment"
  }
}

resource "aws_route_table" "any_to_ngw" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name        = "any-to-ngw"
    Description = "Custom route table for servers in private subnets"
  }
}

resource "aws_route_table_association" "public" {
  for_each = toset([for sub_name, v in var.subnets : sub_name if v.public])

  subnet_id      = aws_subnet.this[each.value].id
  route_table_id = aws_default_route_table.default.id
}

resource "aws_route_table_association" "private" {
  for_each = toset([for sub_name, v in var.subnets : sub_name if !v.public])

  subnet_id      = aws_subnet.this[each.value].id
  route_table_id = aws_route_table.any_to_ngw.id
}
