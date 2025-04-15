provider "aws" {
  region = "us-east-1"
}

module "dmv_waf" {
  source       = "../../modules/waf"
  web_acl_name = "dmv-waf"
  metric_name  = "dmv-waf-metrics"
  alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:575108935978:loadbalancer/app/vita-waf-test-alb/05d040f986b72435"
}
