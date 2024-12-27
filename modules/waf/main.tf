resource "aws_wafv2_web_acl" "main" {
  name        = "${var.project_name}-waf"
  description = var.main_description
  scope       = var.scope

  default_action {
    allow {}
  }

  rule {
    name     = var.rule_name
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = var.managed_rule_group_statement_name
        vendor_name = var.vendor_name
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.rule_cloudwatch_metrics_enabled
      metric_name                = var.rule_visibility_config_metric_name
      sampled_requests_enabled   = var.rule_sampled_requests_enabled
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
    metric_name                = var.waf_visibility_metric_name
    sampled_requests_enabled   = var.waf_sampled_requests_enabled
  }
}
