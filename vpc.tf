# Creating VPC, Subnets, Internet Gateway, Route Table, Security Groups

resource "aws_vpc" "MyVpc" {
  cidr_block = var.vpc_cidr
  tags = {
      "Name" = "MyVpc"
  }
}

resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.MyVpc.id
  cidr_block = var.subnet_cidr

  tags = {
    "Name" = "PublicSubnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.MyVpc.id

  tags = {
    "Name" = "MyIGW"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.MyVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "PublicRt"
  }
}

resource "aws_route_table_association" "AssociatePublicRt" {
  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}