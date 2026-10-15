variable "aws_region" { type = string default = "ap-south-1" }
variable "project" { type = string default = "travelmemory" }
variable "vpc_cidr" { type = string default = "10.20.0.0/16" }
variable "admin_cidr" { type = string description = "Your public IP in /32 CIDR notation" validation { condition = can(cidrhost(var.admin_cidr, 0)) && endswith(var.admin_cidr, "/32") error_message = "Use a single admin public IP, e.g. 203.0.113.10/32." } }
variable "key_name" { type = string description = "Existing AWS EC2 key pair name" }
variable "instance_type" { type = string default = "t3.small" }
variable "ami_id" { type = string default = null description = "Optional Ubuntu 22.04 AMI override" }
