terraform {
  backend "s3" {
    bucket = "sp00800977"
    key = "terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true
    dynamodb_table = "zzz-sss-vvv-ddd"
  }
}