##################################################################################
# IP Set for Whitelisted IPs
##################################################################################
resource "aws_wafv2_ip_set" "allow_whitelist_ips" {
  name               = var.ip_set_name
  description        = var.ip_set_description
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.whitelist_ips
}

##################################################################################
# WAF Web ACL with custom rules and managed rule groups
##################################################################################
resource "aws_wafv2_web_acl" "barath_waf" {
  name        = var.waf_name
  description = var.waf_description
  scope       = "REGIONAL"

  # Define default action (either allow or block)
  default_action {
    dynamic "allow" {
      for_each = var.default_action == "allow" ? [1] : []
      content {}
    }

    dynamic "block" {
      for_each = var.default_action == "block" ? [1] : []
      content {}
    }
  }

  # Rule 1: Allow only whitelisted IPs (everything else blocked)
  rule {
    name     = var.rule_whitelist_name
    priority = 0
    action {
      block {}
    }
    statement {
      not_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.allow_whitelist_ips.arn
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.metrics_enabled
      metric_name                = var.metric_whitelist_name
      sampled_requests_enabled   = var.sampled_requests
    }
  }

  # Rule 2: Block requests from known malicious IPs
  rule {
    name     = var.rule_ip_rep_name
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.metrics_enabled
      metric_name                = var.metric_ip_rep_name
      sampled_requests_enabled   = var.sampled_requests
    }
  }

  # Rule 3: Block requests from anonymized sources (proxies, VPNs, Tor, etc.)
  rule {
    name     = var.rule_anon_ip_name
    priority = 2
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.metrics_enabled
      metric_name                = var.metric_anon_ip_name
      sampled_requests_enabled   = var.sampled_requests
    }
  }

  # Rule 4: Block SQL injection attempts
  rule {
    name     = var.rule_sqli_name
    priority = 3
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = var.metrics_enabled
      metric_name                = var.metric_sqli_name
      sampled_requests_enabled   = var.sampled_requests
    }
  }

  # ACL-wide visibility config
  visibility_config {
    cloudwatch_metrics_enabled = var.metrics_enabled
    metric_name                = var.metric_waf_name
    sampled_requests_enabled   = var.sampled_requests
  }

  tags = {
    Name = var.waf_name
  }
}

##################################################################################
# Associate WAF Web ACL with the Application Load Balancer (ALB)
##################################################################################
resource "aws_wafv2_web_acl_association" "barath_waf" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.barath_waf.arn
}
