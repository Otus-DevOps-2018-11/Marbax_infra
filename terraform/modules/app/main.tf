resource "google_compute_instance" "app" {
  name         = "${var.name}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать static IP для доступа из Интернет
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "op:${file(var.public_key_path)}"
  }

  /* provisioner "file" {
    source      = "../files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "../files/deploy.sh ${self.network_interface.0.address}"
  } */
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
