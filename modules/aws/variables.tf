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
