web_acl_name = "dmv-waf"
metric_name  = "dmv-waf-metrics"
alb_arn      = "arn:aws:elasticloadbalancing:us-east-1:575108935978:loadbalancer/app/vita-waf-test-alb/05d040f986b72435"

managed_rules = [
  {
    name        = "AWS-AWSManagedRulesSQLiRuleSet"
    priority    = 1
    metric_name = "SQLiRule"
    rule_group  = "AWSManagedRulesSQLiRuleSet"
  },
  {
    name        = "AWS-AWSManagedRulesXSSRuleSet"
    priority    = 2
    metric_name = "XSSRule"
    rule_group  = "AWSManagedRulesXSSRuleSet"
  },
  {
    name        = "AWS-AWSManagedRulesCommonRuleSet"
    priority    = 3
    metric_name = "CommonRule"
    rule_group  = "AWSManagedRulesCommonRuleSet"
  },
  {
    name        = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority    = 4
    metric_name = "BadInputsRule"
    rule_group  = "AWSManagedRulesKnownBadInputsRuleSet"
  }
]
