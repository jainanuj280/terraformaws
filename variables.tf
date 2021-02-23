# variable "aws_access_key" {
# }

# variable "aws_secret_key" {
# }

variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR Range for VPC"
  default = "192.168.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR Range for Subnet"
  default = "192.168.1.0/24"
}

variable "ami" {
  description = "AMI details"
  default = "ami-08e0ca9924195beba"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "public_key"
}