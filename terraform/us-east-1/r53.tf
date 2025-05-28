##################################################################################
# ROUTE 53 ALIAS RECORD MODULE
##################################################################################

module "route53_alias" {
  source = "../modules/route53_alias_record"

  # Route 53 hosted zone where the alias record will be created
  zone_id = data.aws_route53_zone.barath_r53.zone_id
  route53_zone_name = var.route53_zone_name
  record_type = var.record_type
  alb_dns_name = data.kubernetes_ingress_v1.user_portal_ingress.status[0].load_balancer[0].ingress[0].hostname
  alb_zone_id = data.aws_lb.app_alb.zone_id
  evaluate_target_health = var.evaluate_target_health
}
