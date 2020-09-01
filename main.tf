provider "google" {
  project = "vvv-test-100001"
  region  = "us-central1"
}

variable "name" {}
variable "machine_type" {}
variable "zone" {}
variable "image" {}
variable "type" {}
variable "size" {
  type = number
}
variable "tags" {
  type = list
}
variable "labels" {
  type = map
}
variable "deletion_protection" {}
variable "network" {}

resource "google_compute_instance" "default" {
  name                = var.name
  machine_type        = var.machine_type
  zone                = var.zone
  deletion_protection = var.deletion_protection

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.type
    }
  }

  network_interface {
    network = var.network
    access_config {
      // Ephemeral IP
    }
  }

  tags                    = var.tags
  metadata_startup_script = file("script.sh")
  labels                  = var.labels
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
