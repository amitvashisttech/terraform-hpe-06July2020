#########GCP##########
terraform {
  backend "gcs" {
    bucket  = "amitvashist7-terraform-state"
    prefix  = "terraform/user/tf01/state/workspaces/"
    credentials = "/tmp/account.json"
  }
}

provider "google" {
  project     = "gleaming-design-282503"
  credentials = "${file("/tmp/account.json")}"
  region      = "us-west1"
  zone        = "us-west1-c"
}

locals {
  default_name = "${join("-", list(terraform.workspace, "example" ))}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "${local.default_name}"
  machine_type = "f1-micro"
  count = 2

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
