provider "aws" {
  region = "us-east-1"
}

module "tax_waf" {
  source              = "../../modules/waf"
  web_acl_name        = var.web_acl_name
  metric_name         = var.metric_name
  alb_arn             = var.alb_arn
  managed_rules       = var.managed_rules
  blocked_ips         = var.blocked_ips
  geo_match_countries = var.geo_match_countries
}

# Triggering workflow test for tax agency via dev branch
