variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Instance zone"
  default     = "europe-west3-c"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "db-base-1548258952"
}

variable name {
  description = "name of the db"
  default     = "reddit-db"
}
