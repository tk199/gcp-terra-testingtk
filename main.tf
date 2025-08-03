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
}
