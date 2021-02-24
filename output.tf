output "instance_ip_addr" {
  value = aws_instance.ec2.private_ip
}

output "vpcid" {
  value = aws_vpc.MyVpc.id
}

output "sshkey" {
  value = tls_private_key.sshkey.private_key_pem
}