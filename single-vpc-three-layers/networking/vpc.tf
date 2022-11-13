resource "aws_vpc" "this" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "nfw_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "nfw_igw"
  }
}

resource "aws_internet_gateway_attachment" "this" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.this.id
}
