terraform {
  backend "s3" {
    bucket = "mongo-atlas-provisioning-automation-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
