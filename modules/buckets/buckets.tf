resource "google_storage_bucket" "state_bucket" {
  name     = "terraform-tk-terra-${var.environment}"  # becomes "my-app-bucket-dev" or "my-app-bucket-stage"
  environment = var.environment
  gcp_resource_location = var.gcp_resource_location
  gcp_project_name = var.gcp_project_name
  }
}