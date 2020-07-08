#########GCP##########
terraform {
  backend "gcs" {
    bucket  = "amitvashist7-terraform-state"
    prefix  = "terraform/user/tf01/state"
    credentials = "/tmp/account.json"
  }
}


######## Remote TFState with Local Backend - Remote DIR ########
#terraform {
#   backend "local" {
#     path = "/tmp/terraform/localbackend/remote-state/demo/terraform.tfstate" 
#  }
#}


provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "test-env-vm1"
  machine_type = "f1-micro"

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
