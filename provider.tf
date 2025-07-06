provider "aws" {
  region = "ap-south-1"
}

resource "aws_dynamodb_table" "my_lock_table" {
  name         = "mytable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "My Lock Table"
    Environment = "Dev"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Example version
    }
  }

  backend "s3" {
    bucket       = "test-bucket-pratcle-new-2"
    key          = "laravel-simple-blog/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true # Boolean (no quotes)
  }
}

