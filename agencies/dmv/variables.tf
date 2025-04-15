variable "alb_arn" {
  description = "ARN of the ALB to associate the WAF with"
  type        = string
}

variable "web_acl_name" {
  description = "Name of the WebACL"
  type        = string
}

variable "metric_name" {
  description = "Name of the top-level metric for the WebACL"
  type        = string
}

variable "managed_rules" {
  description = "List of AWS managed rule groups to enable in the WebACL"
  type = list(object({
    name        = string
    priority    = number
    metric_name = string
    rule_group  = string
  }))
}
