variable "location" {}
variable "environment" {}

locals {
    docker_image_registry_name = var.environment == "dev" || var.environment == "stage" ? "testing-repo" : "${var.environment}-${var.location}-docker-repo"
}


resource "google_artifact_registry_repository" "docker_image_registry" {
    location = var.location
    repository_id = local.docker_image_registry_name
    format = "DOCKER"
    cleanup_policies {
        action = "KEEP"
        id = "${local.docker_image_registry_name}-cleaner"
        most_recent_versions {
            keep_count = 2
            package_name_prefixes = []
        }
    }
    docker_config {
        immutable_tags = false
    }
}