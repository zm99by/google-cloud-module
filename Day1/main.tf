provider "google" {
  credentials = "${file("terraform-admin.json")}"
  project     = "devopslab2020-288208"
  region      = "us-central1"
}