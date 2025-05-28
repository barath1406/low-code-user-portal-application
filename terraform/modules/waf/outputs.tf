##################################################################################
# WAF Module Outputs
##################################################################################

output "web_acl_id" {
  description = "The ID of the WAF Web ACL"
  value       = aws_wafv2_web_acl.barath_waf.id
}

output "web_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = aws_wafv2_web_acl.barath_waf.arn
}

output "ip_set_arn" {
  description = "The ARN of the IP set for whitelisted IPs"
  value       = aws_wafv2_ip_set.allow_whitelist_ips.arn
}
