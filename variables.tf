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