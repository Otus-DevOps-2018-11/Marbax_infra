provider "google" {
  version = "1.19.1"
  project = "${var.project}"
  region  = "${var.region}"
}

/*
resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "op:${file(var.public_key_path)}appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}"
}

connection {
  type        = "ssh"
  user        = "op"
  agent       = true
  private_key = "${file(var.private_key_path)}"
}

provisioner "file" {
  source      = "files/puma.service"
  destination = "/tmp/puma.service"
}

provisioner "remote-exec" {
  script = "files/deploy.sh"
}
*/

