terraform {
  backend "s3" {
    bucket = "s3-bucket-sp-gvfhgffgd"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}