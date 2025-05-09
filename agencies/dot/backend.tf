terraform {
  backend "s3" {
    bucket         = "vita-waf-test-bucket"
    key            = "waf/dot/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "vita-waf-test-locks"
    encrypt        = true
  }
}
