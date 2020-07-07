provider "google" {
  region      = "asia-east1"
  project     = "gleaming-design-282503"
  credentials = "${file("/tmp/account.json")}"
}

provider "google" {
  project     = "gleaming-design-282503"
  credentials = "${file("/tmp/account.json")}"
  region      = "asia-east2"
  alias       = "myregion"
}

variable "asia-east1-zones" {
  default = ["asia-east1-a", "asia-east1-b"]
}

variable "asia-east2-zones" {
  default = ["asia-east2-a", "asia-east2-b"]
}


resource "google_compute_instance" "west_frontend" {
  depends_on 		= ["google_compute_instance.west_backend"]
  name     		= "west-frontend-tf01-${count.index}"
  count    		= 2
  zone     		= "${var.asia-east1-zones[count.index]}"
  machine_type 		= "f1-micro"
  boot_disk {
    initialize_params {
      image 		= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       	= "default"
    access_config {
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance" "frontend" {
  provider      	= "google.myregion"
  depends_on 		= ["google_compute_instance.backend"]
  name     		= "frontend-av-${count.index}"
  count    		= 2
  zone     		= "${var.asia-east2-zones[count.index]}"
  machine_type 		= "f1-micro"
  boot_disk {
    initialize_params {
      image 		= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network    		 = "default"
    access_config {
    }
  }

 lifecycle {
    create_before_destroy = true
  }
}


resource "google_compute_instance" "backend" {
  provider      		= "google.myregion"
  name         			= "backend-${count.index}"
  machine_type 			= "f1-micro"
  count                 	= 2
  zone     			= "${var.asia-east2-zones[count.index]}"
  boot_disk {
    initialize_params {
      image 			= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       		= "default"
    access_config {
    }
  }
  lifecycle {
    prevent_destroy = true
  }
}


resource "google_compute_instance" "west_backend" {
  name         			= "west-backend-${count.index}"
  machine_type 			= "f1-micro"
  count                 	= 2
  zone     			= "${var.asia-east1-zones[count.index]}"
  boot_disk {
    initialize_params {
      image 			= "debian-cloud/debian-9"
    }
  }
  network_interface {
    # A default network is created for all GCP projects
    network       		= "default"
    access_config {
    }
  }
  lifecycle {
    prevent_destroy = true
  }
}


#output "backend_ips" {
#  value = "${list ("${google_compute_instance.backend[*].network_interface[0].access_config[0].nat_ip}","${google_compute_instance.backend[*].network_interface[0].network_ip}")}"
#}



output "frontend" {
  value = "${google_compute_instance.frontend.*.network_interface.0.access_config.0.nat_ip}"
}

output "backend" {
  value = "${google_compute_instance.backend.*.network_interface.0.access_config.0.nat_ip}"
}

output "frontend_west" {
  value = "${google_compute_instance.west_frontend.*.network_interface.0.access_config.0.nat_ip}"
}

output "backend_west" {
  value = "${google_compute_instance.west_backend.*.network_interface.0.access_config.0.nat_ip}"
}
