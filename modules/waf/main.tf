resource "aws_wafv2_ip_set" "blocked_ips" {
  count              = length(var.blocked_ips) > 0 ? 1 : 0
  name               = "${var.web_acl_name}-blocked-ips"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.blocked_ips

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    App = var.web_acl_name
  }
}

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

  # Managed AWS rule groups
  dynamic "rule" {
    for_each = var.managed_rules
    content {
      name     = rule.value.name
      priority = rule.value.priority

      override_action {
        none {}
      }

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

  # Custom IP block rule
  dynamic "rule" {
    for_each = length(var.blocked_ips) > 0 ? [1] : []
    content {
      name     = "BlockBadIPs"
      priority = 50

      action {
        block {}
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.blocked_ips[0].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "block-bad-ips"
        sampled_requests_enabled   = true
      }
    }
  }

  # Custom Geo match rule
  dynamic "rule" {
    for_each = length(var.geo_match_countries) > 0 ? [1] : []
    content {
      name     = "BlockByGeo"
      priority = 51

      action {
        block {}
      }

      statement {
        geo_match_statement {
          country_codes = var.geo_match_countries
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "geo-block"
        sampled_requests_enabled   = true
      }
    }
  }
}

resource "aws_wafv2_web_acl_association" "waf_attach" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
  depends_on   = [aws_wafv2_web_acl.web_acl]
}
