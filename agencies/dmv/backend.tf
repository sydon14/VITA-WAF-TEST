terraform {
  backend "s3" {
    bucket         = "vita-terraform-state-bucket"
    key            = "waf/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}