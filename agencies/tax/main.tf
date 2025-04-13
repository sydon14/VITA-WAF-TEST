provider "aws" {
  region = "us-east-1"
}

module "tax_waf" {
  source         = "../../modules/waf"
  web_acl_name   = "tax-waf"
  metric_name    = "tax-waf-metrics"
  alb_arn        = "arn:aws:elasticloadbalancing:us-east-1:111122223333:loadbalancer/app/tax-app/xyz"
}