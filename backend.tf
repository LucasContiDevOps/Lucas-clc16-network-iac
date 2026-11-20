terraform {
  backend "s3" {
    bucket = "terraform-state-conti-clc16-756437659684-us-east-1-an"
    key    = "terraform/state"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}