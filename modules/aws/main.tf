provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
/*
//Create Primary VPC
resource "aws_vpc" "primary" {
  cidr_block           = var.aws_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

//Create IGW
resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.primary.id
}

//Route Table
resource "aws_route" "primary-internet_access" {
  route_table_id         = aws_vpc.primary.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

resource "aws_route" "peeraccess" {
  route_table_id            = aws_vpc.primary.main_route_table_id
  destination_cidr_block    = var.atlas_vpc_cidr
  vpc_peering_connection_id = mongodbatlas_network_peering.aws-atlas.connection_id
  depends_on                = [aws_vpc_peering_connection_accepter.peer]
}

//Subnet-A
resource "aws_subnet" "primary-az1" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = var.subnet_a_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
}

//Subnet-B
resource "aws_subnet" "primary-az2" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = var.subnet_b_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}b"
}

/*Security-Group
Ingress - Port 80 -- limited to instance
          Port 22 -- Open to ssh without limitations
Egress  - Open to All

resource "aws_security_group" "primary_default" {
  name_prefix = "default-"
  description = "Default security group for all instances in ${aws_vpc.primary.id}"
  vpc_id      = aws_vpc.primary.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      aws_vpc.primary.cidr_block,
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
*/


