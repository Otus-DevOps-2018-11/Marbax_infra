terraform {
  backend "gcs" {
    bucket = "marbax-infra-bucket1"
    prefix = "stage"
  }
}
