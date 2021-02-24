# Create AWS Instance 

# define algo to generate key
resource "tls_private_key" "sshkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate key to login to remote server
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.sshkey.public_key_openssh
}

# create ec2 server
resource "aws_instance" "ec2" {
  subnet_id = aws_subnet.PublicSubnet.id
  ami = var.ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = aws_key_pair.generated_key.key_name
  tags = {
    "Name" = "Webserver"
  }
}

# define security group to server
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

# store private key to local folder
resource "local_file" "private_key" {
    content  = tls_private_key.sshkey.private_key_pem
    filename = var.key_name
}