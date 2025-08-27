provider "aws" {
  region  = "us-east-2"
  profile = "108582616530_AdministratorAccess"
}

terraform {
  backend "s3" {
    bucket       = "terraform-up-and-running-state-manternow"
    key          = "stage/data-stores/mysql/terraform.tfstate"
    region       = "us-east-2"
    profile      = "108582616530_AdministratorAccess"
    use_lockfile = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"
  username            = var.db_username
  password            = var.db_password
}