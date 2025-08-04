variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, stage, prod)"
}

variable "gcp_resource_location" {
  type        = string
  description = "GCP region or zone"
}

variable "gcp_project_name" {
  type        = string
  description = "GCP project name"
}





# resource "google_storage_bucket" "state_bucket" {
#   name     = "terraform-tk-terra-${var.environment}"  # becomes "my-app-bucket-dev" or "my-app-bucket-stage"
#   location = var.gcp_resource_location
#   }