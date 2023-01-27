/*
  module "aws" {
  source = "./modules/aws" 
  //env = var.env
  aws_region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  aws_token = var.aws_token
  aws_account_id = var.aws_account_id
  aws_cidr = var.aws_cidr
 }
 */
 

module "mongodb" {
  source = "./modules/mongodb"
  env = var.env
  public_key = var.public_key
  private_key = var.private_key
  project_id = var.project_id
  project_name = var.project_name
  atlas_region = var.atlas_region
  cluster_name = var.cluster_name
  atlas_dbuser = var.atlas_dbuser
  atlas_dbpassword = var.atlas_dbpassword
  // atlas_vpc_cidr = var.atlas_vpc_cidr
  aws_region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  aws_token = var.aws_token
  aws_vpc_id = var.aws_vpc_id
  aws_account_id = var.aws_account_id
  aws_cidr = var.aws_cidr
}
