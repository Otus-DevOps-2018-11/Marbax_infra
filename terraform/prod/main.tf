provider "google" {
  version = "1.19.1"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  zone            = "${var.zone}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
  name            = "${var.name}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["93.126.79.67/32"]
}
