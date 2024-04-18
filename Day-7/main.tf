provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "<>:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "46684d7e-8c7a-f2dd-4b88-1e9f4eac53eb"
      secret_id = "8e1caaf3-dd27-5433-562f-b8e71cbc5089"
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
