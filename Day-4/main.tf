provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "abhishek" {
  instance_type = "t2.micro"
  ami = "ami-080e1f13689e07408" # change this
  subnet_id = "subnet-0d650db24e1ec20b5" # change this
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "susha-s3-demo" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
