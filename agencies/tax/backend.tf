terraform {
  backend "s3" {
    bucket         = "vita-terraform-state-demo"
    key            = "waf/tax/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vita-waf-demo-locks"
    encrypt        = true
  }
}
