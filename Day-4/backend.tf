terraform {
  backend "s3" {
    bucket         = "susha-s3-demo" # change this
    key            = "susha/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
