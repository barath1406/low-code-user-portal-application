##################################################################################
### Module for WAF & IP Sets ###
##################################################################################

module "waf" {
  source              = "../modules/waf"
  whitelist_ips       = var.whitelist_ips
  waf_name            = var.waf_name
  waf_description     = var.waf_description
  ip_set_name         = var.ip_set_name
  ip_set_description  = var.ip_set_description
  alb_arn             = data.aws_lb.app_alb.arn
  metrics_enabled     = var.metrics_enabled
  sampled_requests    = var.sampled_requests
  default_action      = var.default_action
  
  # Rule Names
  rule_whitelist_name = var.rule_whitelist_name
  rule_ip_rep_name    = var.rule_ip_rep_name
  rule_anon_ip_name   = var.rule_anon_ip_name
  rule_sqli_name      = var.rule_sqli_name
  
  # Metric Names
  metric_whitelist_name = var.metric_whitelist_name
  metric_ip_rep_name    = var.metric_ip_rep_name
  metric_anon_ip_name   = var.metric_anon_ip_name
  metric_sqli_name      = var.metric_sqli_name
  metric_waf_name       = var.metric_waf_name
}