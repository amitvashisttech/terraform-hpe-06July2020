#########GCP##########
provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-central1"
#  version     = "~> 1.20.0"
}

resource "google_compute_instance" "vm_instance" {
  name         = "t01-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
