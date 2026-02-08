variable "aws_region" {
  description = "AWS region where the resources will be created"
  type  = string
  default  = "us-east-1"
}

variable "ssh_key_name" {
  description  = "Name of the existing AWS key pair for ssh access"
  type  = string
}
