provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "${var.project-name}"
  region      = "${var.region}"
}
