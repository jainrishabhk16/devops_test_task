variable "project_name" {
  type = string
}

variable "main_description" {
  default = "WAF for ALB"
}

variable "scope" {
  default = "REGIONAL"
}

variable "rule_name" {
  default = "AWSManagedRulesCommonRuleSet"
}
variable "managed_rule_group_statement_name" {
  default = "AWSManagedRulesCommonRuleSet"
}

variable "vendor_name" {
  default = "AWS"
}

variable "rule_visibility_config_metric_name" {
  default = "AWSManagedRulesCommonRuleSetMetric"
}

variable "waf_visibility_metric_name" {
  default = "WAFMainMetrics"
}

variable "rule_cloudwatch_metrics_enabled" {
  type    = bool
  default = true
}

variable "rule_sampled_requests_enabled" {
  type    = bool
  default = true
}

variable "waf_cloudwatch_metrics_enabled" {
  type    = bool
  default = true
}
variable "waf_sampled_requests_enabled" {
  type    = bool
  default = true
}
