provider "aws" {
  region = "us-east-1"
}

module "dmv_waf" {
  source         = "../../modules/waf"
  web_acl_name   = "dmv-waf"
  metric_name    = "dmv-waf-metrics"
  alb_arn        = "arn:aws:elasticloadbalancing:us-east-1:111122223333:loadbalancer/app/dmv-app/xyz"
}

# This is a simulation update for DMV WAF deployment
