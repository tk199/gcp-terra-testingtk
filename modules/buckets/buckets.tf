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


variable "create_state_bucket" {
  type        = bool
  description = "Whether to create the Terraform state bucket"
  default     = false
}

resource "google_storage_bucket" "state_bucket" {
  count    = var.create_state_bucket ? 1 : 0
  name     = "terraform-tk-terra-${var.environment}"
  location = var.gcp_resource_location
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  labels = {
    environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

