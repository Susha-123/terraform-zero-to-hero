provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://44.201.169.57:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "4d5071a6-c40b-4836-7423-be2aeba511cc"
      secret_id = "a554a4eb-6b1a-d960-d212-55261c015241"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv2" // change it according to your mount
  name  = "test" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["user"]
  }
}
