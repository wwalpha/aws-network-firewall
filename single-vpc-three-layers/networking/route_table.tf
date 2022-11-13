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

# resource "aws_route_table" "private_1a" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "nfw_private_rt_1a"
#   }
# }

# # resource "aws_route" "private_1a" {
# #   route_table_id         = aws_route_table.private_1a.id
# #   destination_cidr_block = "0.0.0.0/0"
# #   nat_gateway_id         = aws_nat_gateway.az_1a.id
# # }

# resource "aws_route_table_association" "private_1a" {
#   route_table_id = aws_route_table.private_1a.id
#   subnet_id      = aws_subnet.private_1a.id
# }

# resource "aws_route_table" "private_1d" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "nfw_private_rt_1d"
#   }
# }

# # resource "aws_route" "private_1d" {
# #   route_table_id         = aws_route_table.private_1d.id
# #   destination_cidr_block = "0.0.0.0/0"
# #   nat_gateway_id         = aws_nat_gateway.az_1d.id
# # }

# resource "aws_route_table_association" "private_1d" {
#   route_table_id = aws_route_table.private_1d.id
#   subnet_id      = aws_subnet.private_1d.id
# }




# resource "aws_route_table_association" "public" {
#   for_each       = local.firewall_map
#   route_table_id = aws_route_table.public[each.key].id
#   subnet_id      = each.key
# }

# resource "aws_route_table" "public_1a" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "nfw_public_rt_1a"
#   }
# }

# resource "aws_route" "public_1a" {
#   route_table_id         = aws_route_table.public_1a.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.az_1a.id
# }

# resource "aws_route_table_association" "public_1a" {
#   route_table_id = aws_route_table.public_1a.id
#   subnet_id      = aws_subnet.public_1a.id
# }

# resource "aws_route_table" "public_1d" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "nfw_public_rt_1d"
#   }
# }

# resource "aws_route" "public_1d" {
#   route_table_id         = aws_route_table.public_1d.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.az_1a.id
# }

# resource "aws_route_table_association" "public_1d" {
#   route_table_id = aws_route_table.public_1d.id
#   subnet_id      = aws_subnet.public_1d.id
# }


# resource "aws_route" "firewall" {
#   route_table_id         = aws_route_table.firewall.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.az_1a.id
# }

# resource "aws_route_table" "firewall" {
#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "nfw_firewall_rt"
#   }
# }

# resource "aws_route_table_association" "firewall_1a" {
#   route_table_id = aws_route_table.firewall.id
#   subnet_id      = aws_subnet.nfw_1a.id
# }

# resource "aws_route_table_association" "firewall_1d" {
#   route_table_id = aws_route_table.firewall.id
#   subnet_id      = aws_subnet.nfw_1d.id
# }
