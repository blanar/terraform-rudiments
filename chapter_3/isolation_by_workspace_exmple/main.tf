provider "aws" {
  region  = "us-east-2"
  profile = "108582616530_AdministratorAccess"
}

resource "aws_instance" "example" {
  ami           = "ami-0d1b5a8c13042c939"
  instance_type = "t2.micro"
}

terraform {
  backend "s3" {
    bucket       = "terraform-up-and-running-state-manternow"
    key          = "workspace-example/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    profile      = "108582616530_AdministratorAccess"
    encrypt      = true
  }
}