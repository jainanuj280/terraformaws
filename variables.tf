# variable "aws_access_key" {
#   description = "Enter Access Key"
# }

# variable "aws_secret_key" {
#   description = "Enter Secret Key"
# }

variable "key_name" {
  description = "Enter Ssh Key Name"
}

variable "region" {
  description = "Region Name"
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