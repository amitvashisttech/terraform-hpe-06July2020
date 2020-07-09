provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
