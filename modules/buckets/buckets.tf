resource "google_storage_bucket" "state_bucket" {
  name     = "terraform-tk-terra-${var.environment}"  # becomes "my-app-bucket-dev" or "my-app-bucket-stage"
  location = var.gcp_resource_location
  force_destroy = true

  versioning {
    enabled = true
  }

  labels = {
    environment = var.environment
    project     = var.gcp_project_name
  }
}