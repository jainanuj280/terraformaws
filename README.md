This terraform script help to Setup VPC, Public/Private Subnets, Internet Gateway, Route Table, Security Groups, EC2 Instance With Terraform

# Prerequisites
    AWS Account
    IAM user access key and secret key (IAM user should have permission to create required resources).
    
# Commands to run terraform Script
    1. clone this repo to your local
    2. initialize terraform using command "terraform init"
    3. terraform apply
        a. it will ask for the AWS secret key and Access key you need to pass those
        b. it will also ask for sshkey name will be helpfull to login to that server
    4. after setup make sure to destroy the setup if not needed any more "terraform destroy"
