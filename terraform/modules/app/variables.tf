variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Instance zone"
  default     = "europe-west3-c"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "app-base-1548258945"
}

variable name {
  description = "Name of the app"
  default     = "reddit-app"
}
