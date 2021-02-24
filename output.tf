# Get Output of the resources created

output "instance_ip_addr" {
  value = aws_instance.ec2.private_ip
}

output "vpcid" {
  value = aws_vpc.MyVpc.id
}
