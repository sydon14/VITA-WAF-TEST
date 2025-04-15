web_acl_name = "dmv-waf"
metric_name  = "dmv-waf-metrics"
alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:575108935978:loadbalancer/app/vita-waf-test-alb/05d040f986b72435"

# ✅ AWS MANAGED RULE GROUPS
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

# CUSTOM RULES - IP Blocking
blocked_ips = [
  "198.51.100.1/32",
  "203.0.113.45/32"
]

# CUSTOM RULES - Country Blocking
geo_match_countries = [
  "RU", # Russia
  "CN"  # China
]
