provider "aws" {
  region = "us-east-1"
}

module "dot_waf" {
  source         = "../../modules/waf"
  web_acl_name   = "dot-waf"
  metric_name    = "dot-waf-metrics"
  alb_arn        = "arn:aws:elasticloadbalancing:us-east-1:111122223333:loadbalancer/app/dot-app/xyz"
}