# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "4.63.0"
      version = "5.13.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "aws" {}

resource "random_string" "random" {
  length  = var.random_string_length
  special = false
  upper   = false
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "ec2_aws_sc_selfservice" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "ec2-demo-servicecatalog-${random_string.random.result}"
    Owner = "AWS-ServiceCatalog"
  }
}

output "instance-id" {
  value = aws_instance.ec2_aws_sc_selfservice.id
}

variable "instance_type" {
  default = "t2.small"
  description = "The AWS Machine type that you want to provision"
  type = string
}

variable "random_string_length" {
    default = 4
}