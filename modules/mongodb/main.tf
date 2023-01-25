provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

#resource "mongodbatlas_project" "aws_atlas" {
#   name   = var.project_name
#   org_id = var.atlasorgid
#}

# expt below
# data "mongodbatlas_cluster" "clusterdata" {
#     project_id = var.project_name.project_id
#     name = var.project_name.name
# }

resource "mongodbatlas_cluster" "cluster-atlas" {
  # project_id   = mongodbatlas_project.aws_atlas.id
  # project_id   = data.mongodbatlas_cluster.clusterdata.project_id
  project_id = var.project_id
  name         = var.cluster_name
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.atlas_region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  # Provider Settings "block"
  provider_name               = "AWS"
  disk_size_gb                = 10
  provider_instance_size_name = "M10"
  count = var.env == "dev" ? 1 : 0
}
resource "mongodbatlas_database_user" "db-user" {
  username           = var.atlas_dbuser
  password           = var.atlas_dbpassword
   auth_database_name = "admin"
   # project_id         = mongodbatlas_project.aws_atlas.id
   # project_id   = data.mongodbatlas_cluster.clusterdata.project_id
   project_id = var.project_id
   roles {
     role_name     = "readWrite"
     database_name = "admin"
   }
   # depends_on = [mongodbatlas_project.aws_atlas]
 }

 resource "mongodbatlas_network_container" "atlas_container" {
   atlas_cidr_block = var.atlas_vpc_cidr
   #project_id       = mongodbatlas_project.aws_atlas.id
   project_id = var.project_id
   provider_name    = "AWS"
   region_name      = var.atlas_region
 }

 data "mongodbatlas_network_container" "atlas_container" {
   container_id = mongodbatlas_network_container.atlas_container.container_id
   #project_id   = mongodbatlas_project.aws_atlas.id
   project_id = var.project_id
 }

 resource "mongodbatlas_network_peering" "aws-atlas" {
   count = var.aws_vpc_id ? 1 : 0
   accepter_region_name   = var.aws_region
   #project_id             = mongodbatlas_project.aws_atlas.id
   project_id = var.project_id
   container_id           = mongodbatlas_network_container.atlas_container.container_id
   provider_name          = "AWS"
   # route_table_cidr_block = aws_vpc.primary.cidr_block
   # vpc_id                 = aws_vpc.primary.id
   route_table_cidr_block = var.aws_cidr
   vpc_id                 = var.aws_vpc_id
   aws_account_id         = var.aws_account_id
 }

 resource "mongodbatlas_project_ip_access_list" "test" {
   count = var.aws_vpc_id ? 1 : 0
   #project_id = mongodbatlas_project.aws_atlas.id
   project_id = var.project_id
   # cidr_block = aws_vpc.primary.cidr_block
   cidr_block = var.aws_cidr
   comment    = "cidr block for AWS VPC"
 }
