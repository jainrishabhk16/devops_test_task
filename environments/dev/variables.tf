# VPC
variable "project_name" {}
variable "aws_region" {

}
variable "environment" {

}
variable "vpc_cidr" {

}


variable "private_subnets" {
  
}

variable "public_subnets" {
  
}


#waf
variable "waf_scope" {

}
variable "rule_name" {

}

variable "managed_rule_group_statement_name" {

}

variable "vendor_name" {

}

variable "rule_cloudwatch_metrics_enabled" {

}
variable "rule_sampled_requests_enabled" {

}
variable "rule_visibility_config_metric_name" {

}

variable "waf_cloudwatch_metrics_enabled" {

}

variable "waf_visibility_metric_name" {

}

variable "waf_sampled_requests_enabled" {

}


# Load balancer
# variable "subnets" {
  
# }
variable "load_balancer_type" {

}
variable "http_target_group_name" {

}
variable "target_group_port" {

}
variable "target_group_protocol" {

}
variable "alb_listener_port" {

}
variable "alb_listener_protocol" {

}

# security groups
variable "ingress_cidr_block" {

}
variable "ingress_from_port" {

}
variable "ingress_to_port" {

}

variable "inrgess_protocol" {

}

# eks
variable "capacity_type" {

}
variable "instance_types" {

}

variable "min_size" {
  
}
variable "max_size" {
  
}
variable "desired_size" {
  
}
variable "volume_size" {
  
}
variable "volume_type" {
  
}
variable "encrypted" {
  
}
variable "delete_on_termination" {
  
}
variable "fargate_profiles_name" {

}

variable "fargate_profiles_namespace" {
  
}