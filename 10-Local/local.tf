provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-west1"
}

provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-central1"
  alias       = "myregion"
}

variable "us-west-zones" {
  default = ["us-west1-a", "us-west1-b"]
}

variable "us-central-zones" {
  default = ["us-central1-a", "us-central1-b"]
}

variable "multi-region-deployment" {
  default = false
}

variable "environment-name" {
  default = "tfdemo"
}


locals {
  default_frontend_name = "${join("-",list(var.environment-name, "proxy"))}"
  default_backend_name  = "${join("-",list(var.environment-name, "database"))}"
}




resource "google_compute_instance" "frontend" {
  provider      	= "google.myregion"
  name     		= "${local.default_frontend_name}"
  #name     		= "${join("-",list(var.environment-name, "frontend"))}"
  depends_on 		= ["google_compute_instance.backend"]
  count    		= 1
  zone     		= "${var.us-central-zones[count.index]}"
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
}


resource "google_compute_instance" "backend" {
  provider      		= "google.myregion"
  name     		        = "${local.default_backend_name}"
  #name     		        = "${join("-",list(var.environment-name, "backend"))}"
  machine_type 			= "f1-micro"
  count                 	= 1
  zone     			= "${var.us-central-zones[count.index]}"
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
    prevent_destroy = false
  }
}
