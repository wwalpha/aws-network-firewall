resource "aws_route_table" "private" {
  count  = length(local.availability_zones)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = {
    Name = format(
      "nfw_private_rt_%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

resource "aws_route_table" "public" {
  count  = length(local.availability_zones)
  vpc_id = aws_vpc.this.id

  route {
    cidr_block      = "0.0.0.0/0"
    vpc_endpoint_id = local.firewall_endpoints[count.index]
  }

  tags = {
    Name = format(
      "nfw_public_rt_%s",
      split("-", element(local.availability_zones, count.index))[2],
    )
  }
}

resource "aws_route_table" "firewall" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "nfw_firewall_rt"
  }
}
