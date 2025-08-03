# variables.tf
variable "google_credentials" {
  description = "GCP credentials"
  type        = string
}

variable "gcp_product_id" {
  type = string
  description = "GCP project id"
}

variable "gcp_project_name" {
  type = string
  description = "GCP project name"
}

variable "gcp_project_number" {
  type = number
  description = "GCP project number"
}

variable "gcp_resource_location" {
  type = string
  description = "GCP resource location"
}

variable "environment" {
  type = string
  description = "GCP resource environment"
}

variable "use_existing_ips" {
  description = "Set true to use existing IP address, false to allocate to a new one"
  type = bool
  default = false
}