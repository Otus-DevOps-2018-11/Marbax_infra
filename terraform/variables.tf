variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west3"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Private key path"
}

variable zone {
  description = "Instance zone"
  default     = "europe-west3-c"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "app-base-1548258945"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "db-base-1548258952"
}

variable name {
  description = "name of the db"
  default     = "reddit-db"
}
