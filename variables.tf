variable "env" {
  default = "dev"
}

# MongoDB Variables Below
variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}

variable "atlas_dbuser" {
   description = "The db user for Atlas"
   default = "mongodb"
 }

 variable "atlas_dbpassword" {
   description = "The db user passwd for Atlas"
 }

variable "cluster_name" {
  description = "cluster name"
}

variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}

variable "atlas_region" {
  default     = "US_EAST_1"
  description = "Atlas Region"
}

variable "atlasorgid" {
  description = "Atlas Org ID"
  default     = "625e8ee725e33a22794e0bad"
}

/*
variable "atlas_vpc_cidr" {
  description = "Atlas CIDR"
  default     = "192.168.232.0/21"
}
*/

variable "project_name" {
  description = "MongoDB Atlas project name to create new project"
  default     = "wo-sre-dev-cluster"
}

variable "project_id" {
  description = "MongoDB Atlas project id for project wo-sre-dev-cluster"
  default     = "625e8f54c6f9c330400eb8c9"
}

# AWS Variables Below
variable "access_key" {
  description = "The access key for AWS Account"
}

variable "secret_key" {
  description = "The secret key for AWS Account"
}

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "aws_account_id" {
  description = "My AWS Account ID, Default to Dev AWS A/c"
  default     = "640365590647"
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
