provider "aws" {
  region = "ap-south-1"
}

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

resource "aws_instance" "ec2" {
  subnet_id = aws_subnet.PublicSubnet.id
  ami = var.ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = aws_key_pair.key.id
  tags = {
    "Name" = "Myec2"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.MyVpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    "Name" = "SG"
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

resource "aws_route_table_association" "PublicRRt" {
  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_key_pair" "key" {
  key_name = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYevFyqia/pq1/HqwD/GYOs46WTh36DyHRFHWyvTJODRlDALlOYzfhFGzHH8q2XLlI8h/XN/3srPKIyfOwjAuRZpqAivwwStzQBdDe/kXeD6WtG+jMm578GrQzEonB56W//xht1UXu+EpsCqBh/nQOoMKqzStWJYR0XmlEpV7STSm0OnpKBm1Q1Q94G5UuahBNE1SEc0o5NKQ/LXJonHtO1t8I48VDl3oDf1ZdfTuVp7TBkXgjKRH3d0hV4lhi6c4cCizNrsjKaxc+j3KcPqDuPuO76EyfLeh4IE9SSdK5iShYvw+7cxt0jVLhM7jkc4PAtZz5sVH8/kPBoK03NT+7 administrator@EC2AMAZ-IFRVBKJ"
}