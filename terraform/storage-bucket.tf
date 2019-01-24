provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.1.1"

  # Имена поменяйте на другие
  name = ["marbax-infra-bucket1", "marbax-infra-bucket2"]
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
