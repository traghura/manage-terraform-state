# terraform.tf
terraform {
 backend "s3" {
 encrypt = true
 bucket = "terraform-up-and-running-state621"
 dynamodb_table = "terraform-state-lock-dynamo"
 region = "us-east-1"
 key = "global/s3/terraform.tfstate"
 }
}