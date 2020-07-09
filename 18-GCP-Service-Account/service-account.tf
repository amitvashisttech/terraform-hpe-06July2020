#########GCP##########
provider "google" {
  credentials = "${file("/tmp/account.json")}"
  project     = "gleaming-design-282503"
  region      = "us-west1"
  zone        = "us-west1-c"
}

resource "google_service_account" "service_account" {
  display_name       = "Test TF Service Account"
  account_id = "test-svc-acctf01"
}
