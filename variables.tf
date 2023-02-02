variable "env" {
  default = "dev"
}

# MongoDB Variables Below
variable "public_key" {
  description = "The public API key for MongoDB Atlas"
  sensitive = true
}

variable "atlas_dbuser" {
   description = "The db user for Atlas"
   default = "mongodb"
 }

 variable "atlas_dbpassword" {
   description = "The db user passwd for Atlas"
   sensitive   = true
 }

variable "cluster_name" {
  description = "cluster name"
}

variable "private_key" {
  description = "The private API key for MongoDB Atlas"
  sensitive = true
}

variable "atlas_region" {
  description = "Atlas Region"
}

/*
variable "atlas_vpc_cidr" {
  description = "Atlas CIDR"
  default     = "192.168.232.0/21"
}
*/

variable "project_name" {
  description = "MongoDB Atlas project name to create new project"
}

variable "project_id" {
  description = "MongoDB Atlas project id for project wo-sre-dev-cluster"
}

variable "instance_size" {
  description = "Atlas provides different instance sizes, each with a default storage capacity and RAM size. The instance size you select is used for all the data-bearing servers in your cluster."
  default = "M10"
}

variable "disk_size_gb" {
  description = "Capacity, GB, of the host’s root volume."
  default = 10
}

# AWS Variables Below
variable "access_key" {
  description = "The access key for AWS Account"
}

variable "secret_key" {
  description = "The secret key for AWS Account"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "aws_account_id" {
  description = "My AWS Account ID, Default to Dev AWS A/c"
}

variable "aws_vpc_id" {
  description = "AWS VPC id"
}

variable "aws_token" {}

variable "aws_cidr" {
  description = "AWS VPC cidr block"
  default     = "10.0.0.0/16"
}
/*
variable "subnet_a_cidr" {
  description = "aws vpc subnet a cidr block"
  default     = "10.0.1.0/24"
}
variable "subnet_b_cidr" {
  description = "aws vpc subnet b cidr block"
  default     = "10.0.2.0/24"
}
*/
