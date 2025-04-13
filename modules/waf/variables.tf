variable "web_acl_name" {
  description = "The name of the WebACL"
  type        = string
}

variable "metric_name" {
  description = "The name for metrics"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the ALB to associate with the WAF"
  type        = string
}