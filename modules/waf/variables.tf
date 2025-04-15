variable "web_acl_name" {
  description = "Name of the Web ACL"
  type        = string
}

variable "metric_name" {
  description = "Name of the CloudWatch metric"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}

variable "managed_rules" {
  description = "List of AWS managed rule groups to enable"
  type = list(object({
    name        = string
    priority    = number
    metric_name = string
    rule_group  = string
  }))
}
