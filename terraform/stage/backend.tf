terraform {
  backend "gcs" {
    bucket = "marbax-infra-bucket2"
    prefix = "stage"
  }
}
