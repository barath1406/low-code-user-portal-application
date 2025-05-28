##################################################################################
### Resource for AWS Route 53 Alias Record                                     ###
##################################################################################

# Create a Route 53 DNS record to alias to an Application Load Balancer (ALB)
resource "aws_route53_record" "app_alias" {
  
  # Route 53 Zone and Record Settings
  zone_id = var.zone_id                        # The ID of the Route 53 hosted zone
  name    = var.route53_zone_name              # The DNS name for the record (e.g., www.example.com)
  type    = var.record_type                    # The type of DNS record, typically A or CNAME
  
  # Alias configuration to point to an ALB
  alias {
    name                   = var.alb_dns_name   # The DNS name of the ALB (e.g., my-alb-12345678.us-west-2.elb.amazonaws.com)
    zone_id                = var.alb_zone_id    # The zone ID of the ALB (can be found in AWS documentation)
    evaluate_target_health = var.evaluate_target_health # Whether to evaluate the health of the ALB target
  }
}
