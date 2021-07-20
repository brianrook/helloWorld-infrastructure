provider "aws" {
  region     = "${var.aws_region}"
  shared_credentials_file = "/Users/brianrook/.aws/credentials"
}
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "awstraining_terraform-up-and-running-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "awstraining_terraform_state" {
  bucket                      = "awstraining-terraform-up-and-running-state"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled    = true
  }
}

