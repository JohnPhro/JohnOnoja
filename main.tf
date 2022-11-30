# terraforn init
# terraform plan
# terraform apply
# terraform destory

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "us-east-1"
    
}

# creating a VPC
resource "aws_vpc" "JohnVPC" {
  cidr_block = "172.31.0.0/24"
  
  tags = {
    Name = "JohnVPC"
}
}

# Creat security group

resource "aws_security_group" "JohnSG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.JohnVPC.id 
} 

# EC2 provisioning

data "aws_instance" "JohnEC2" {
  instance_id = "i-instanceid"

  filter {
    name   = "John_instance"
    value  =["ami-0b0dcb5067f052a63"]
  }

  filter {
    name   = "tag:John_instance"
    values = ["instance-name-tag"]
  }
}

##Provisioning SG

resource "aws_placement_group" "JohnSGG" {
  name     = "JohnSG"
  strategy = "cluster"
}












