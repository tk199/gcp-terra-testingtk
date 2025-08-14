locals {
    apis = [
        "certificatemanager.googleapis.com",
        "artifactregistry.googleapis.com",
        "cloudidentity.googleapis.com",
        "cloudkms.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "compute.googleapis.com",
        "container.googleapis.com",
        "containerthreatdetection.googleapis.com",
        "dns.googleapis.com",
        "iam.googleapis.com",
        "iamcredentials.googleapis.com",
        "logging.googleapis.com",
        "monitoring.googleapis.com",
        "servicenetowrking.googleapis.com",
        "storage-component.googleapis.com",
        "sts.googleapis.com",
        "run.googleapis.com",
        "eventarc.googleapis.com",
        "recommender.googleapis.com",
        "file.googleapis.com",
        "vpcaccess.googleapis.com",
        "networksecurity.googleapis.com",
        "appengine.googleapis.com"
    ]
}

resource "google_project_service" "services" {
    for_each = toset(local.apis)
    service = each.key
    disable_on_destroy = false
    disable_dependent_services = true
}