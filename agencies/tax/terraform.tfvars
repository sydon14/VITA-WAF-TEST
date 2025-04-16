web_acl_name = "tax-waf"
metric_name  = "tax-waf-metrics"
alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:575108935978:loadbalancer/app/tax-alb/abc123"

managed_rules = [
  {
    name        = "SQLiRuleSet"
    priority    = 1
    metric_name = "SQLiRule"
    rule_group  = "AWSManagedRulesSQLiRuleSet"
  },
  {
    name        = "CommonRuleSet"
    priority    = 2
    metric_name = "CommonRule"
    rule_group  = "AWSManagedRulesCommonRuleSet"
  },
  {
    name        = "BadInputsRuleSet"
    priority    = 3
    metric_name = "BadInputsRule"
    rule_group  = "AWSManagedRulesKnownBadInputsRuleSet"
  }
]

blocked_ips = [
  "198.51.100.1/32",
  "203.0.113.45/32"
]

geo_match_countries = [
  "RU",
  "CN"
]
