resource "google_project_service" "compute_api" {
  project = "tk-terra-dev"
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}


resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "vpc-network"
    subnetwork = "test-subnetwork"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
      scopes = ["cloud-platform"]
  }
}



resource "google_compute_disk" "datadisk" {
  name  = "data-disk"
  type  = "pd-standard"
  zone = "us-central1-a"
}


resource "google_compute_attached_disk" "datadisk-attach" {
  disk     = google_compute_disk.datadisk.id
  instance = google_compute_instance.default.id
}