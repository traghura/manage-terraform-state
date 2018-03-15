# example.tf
provider "aws" {
  region = "us-east-1"
}

output "s3_bucket_arn" {
    value = "${aws_s3_bucket.terraform_state.arn}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state621"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

# create a dynamodb table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}