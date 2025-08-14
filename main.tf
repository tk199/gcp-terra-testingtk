terraform {
  backend "gcs" {}
}


module "compute" {
    source = "./modules/compute"
}

module "network" {
    source = "./modules/network"
}

module "buckets" {
  source              = "./modules/buckets"
  environment         = var.environment
  gcp_resource_location = var.gcp_resource_location
  gcp_project_name    = var.gcp_project_name
  create_state_bucket   = var.create_state_bucket
}

module "artifact-registry" {
    source = "./modules/artifact-registry"
    location = var.gcp_resource_location
    environment = var.environment
}

module "bootstrap" {
    source = "./modules/bootstrap/"
}
