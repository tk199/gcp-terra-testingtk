module "compute" {
    source = "./modules/compute"
}

module "network" {
    source = "./modules/network"
}

module "buckets" {
    source = "./modules/buckets"
}