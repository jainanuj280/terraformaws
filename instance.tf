resource "tls_private_key" "sshkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.sshkey.public_key_openssh
}

resource "aws_instance" "ec2" {
  subnet_id = aws_subnet.PublicSubnet.id
  ami = var.ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = aws_key_pair.generated_key.key_name
  tags = {
    "Name" = "Myec2"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.MyVpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
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
