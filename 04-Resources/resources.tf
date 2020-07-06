#########GCP##########
provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_compute_instance" "frontend" {
  name         = "frontend-av"
  machine_type = "f1-micro"
  depends_on   = ["google_compute_instance.backend"]

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

  lifecycle {
    create_before_destroy = true
  }

}



resource "google_compute_instance" "backend" {
  name         = "backend-av"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "centos-6"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }

  lifecycle {
    prevent_destroy = false
  }
 
}
