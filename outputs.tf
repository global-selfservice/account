output "external_zone_id" {
  value       = var.external_zone != "" ? aws_route53_zone.org[0].zone_id : ""
  description = "External DNS zone ID"
}

output "external_domain_name" {
  value       = var.external_zone
  description = "External DNS domain name"
}
