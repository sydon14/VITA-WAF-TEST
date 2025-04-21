web_acl_name = "dmv-waf"
metric_name  = "dmv-waf-metrics"
alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:575108935978:loadbalancer/app/dmv-waf-test-alb/9c02b528dfe6dfd2"

# AWS MANAGED RULE GROUPS
managed_rules = [
  {
    name        = "SQLiRuleSet"
    priority    = 1
    metric_name = "SQLiRule"
    rule_group  = "AWSManagedRulesSQLiRuleSet"
  },
  {
    name        = "XSSRuleSet"
    priority    = 2
    metric_name = "XSSRule"
    rule_group  = "AWSManagedRulesXSSRuleSet"
  },
  {
    name        = "CommonRuleSet"
    priority    = 3
    metric_name = "CommonRule"
    rule_group  = "AWSManagedRulesCommonRuleSet"
  },
  {
    name        = "BadInputsRuleSet"
    priority    = 4
    metric_name = "BadInputsRule"
    rule_group  = "AWSManagedRulesKnownBadInputsRuleSet"
  },
  {
    name        = "AdminProtection"
    priority    = 5
    metric_name = "AdminProtection"
    rule_group  = "AWSManagedRulesAdminProtectionRuleSet"
  },
  {
    name        = "AmazonIPReputation"
    priority    = 6
    metric_name = "AmazonIPReputation"
    rule_group  = "AWSManagedRulesAmazonIpReputationList"
  },
  {
    name        = "AnonymousIPList"
    priority    = 7
    metric_name = "AnonymousIPList"
    rule_group  = "AWSManagedRulesAnonymousIpList"
  },
  {
    name        = "BotControl"
    priority    = 8
    metric_name = "BotControl"
    rule_group  = "AWSManagedRulesBotControlRuleSet"
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
