provider "aws" {
  region  = "us-east-2"
  profile = "108582616530_AdministratorAccess"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-manternow"
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning so you can see the full revision history of your
# state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

terraform {
  backend "s3" {
    bucket       = "terraform-up-and-running-state-manternow"
    key          = "global/s3/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    profile      = "108582616530_AdministratorAccess"
    encrypt      = true
  }
}
