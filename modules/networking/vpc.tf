variable "location" {}
variable "environment" {}

locals {
    vpc_name = var.environment == "dev" || var.environment == "stage" ? "test-vpc" : "${var.environment}-${var.location}-vpc"
    primary_subnet_name = var.environment == "dev" || var.environment == "stage" ?  "test-subnet" : "${var.environment}-${var.location}-subnet"
    connector_subnet_name = var.environment == "dev" || var.environment == "stage" ? "test-subnet2" : "${var.environment}-${var.location}-connector-subnet2"
    fw_allow_http_ingress_name = var.environment == "dev" || var.environment == "stage" ? "test-allow-http-ingress" : "${var.environment}-${var.location}-allow-http-ingress"
    fw_block_all_ingress_name = var.environment == "dev" || var.environment == "stage" ? "test-block-http-ingress" : "${var.environment}-${var.location}-block-http-ingress"
}

resource "google_compute_network" "vpc" {
    name = local.vpc_name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "primary_subnet" {
    name = local.primary_subnet_name
    ip_cidr_range = "10.1.0.0/24"
    region = var.location
    network = google_compute_network.vpc.id
    lifecycle { ignore_changes = [log_config]}
}

resource "google_compute_subnetwork" "connector_subnet" {
    name = local.connector_subnet_name
    ip_cidr_range = "10.1.0.0/28"
    region = var.location
    network = google_compute_network.vpc.id
    lifecycle { ignore_changes = [log_config]} 
}

resource "google_compute_firewall" "allow_http_ingress" {
    direction = "INGRESS"
    name = local.fw_allow_http_ingress_name
    network = google_compute_network.vpc.id
    priority = 1100

    allow {
        protocol = "tcp"
        ports = ["443", "80"]
    }

    log_config {
        metadata = "INCLUDE_ALL_METADATA"
    }
}

resource "google_compute_firewall" "block_all_ingress" {
    direction = "INGRESS"
    name = local.fw_block_all_ingress_name
    network = google_compute_network.vpc.id
    priority = 1000
    source_ranges = ["0.0.0.0/0"]
    source_tags = []
    deny {
        ports = ["22"]
        protocol = "tcp"
    }
}


output "vpc_name" {
    value = google_compute_network.vpc.name
}

output "vpc_id" {
    value = google_compute_network.vpc.id
}

output "connector_subnet_name" {
    value = google_compute_subnetwork.connector_subnet.name
}

output "connector_subnet_id" {
    value = google_compute_subnetwork.primary_subnet.id
}

output "primary_subnet_name" {
    value = google_compute_subnetwork.primary_subnet.name
}

output "primary_subnet_id" {
    value = google_compute_subnetwork.primary_subnet.id
}