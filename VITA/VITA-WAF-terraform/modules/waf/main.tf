resource "aws_wafv2_web_acl" "web_acl" {
  name  = var.web_acl_name
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.metric_name
    sampled_requests_enabled   = true
  }

  dynamic "rule" {
    for_each = [
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

    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {}

      statement {
        managed_rule_group_statement {
          name        = rule.value.rule_group
          vendor_name = "AWS"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = true
      }
    }
  }
}