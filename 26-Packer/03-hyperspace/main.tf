provider "google" {
  credentials = "/tmp/account.json"
  project      = "gleaming-design-282503"
  region       = "us-west1"
}

//
// INSTANCES
//
resource "google_compute_instance" "hyperspace" {
  name         = "hyperspace"
  machine_type = "n1-standard-1"
  zone         = "us-west1-a"
  tags = ["hyperspace"]

  boot_disk {
    initialize_params {
      image = "hyperspace-1594294137"
    }
  }

  network_interface {
      network = "default"
      access_config {
          // Ephemeral IP
      }
  }
  count = 1
  lifecycle = {
    create_before_destroy = true
  }
}

//
// NETWORKING
//
resource "google_compute_firewall" "fwrule" {
    name = "hyperspace-web"
    network = "default"
    allow {
        protocol = "tcp"
        ports = ["80"]
    }
    target_tags = ["hyperspace"]
}

