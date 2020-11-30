resource "aws_route53_zone" "org" {
  count = var.external_zone != "" ? 1 : 0

  name = var.external_zone
}

resource "aws_route53_record" "delegation" {
  for_each = var.delegation

  zone_id = aws_route53_zone.org[0].zone_id
  name    = "${each.key}.${aws_route53_zone.org[0].name}"
  type    = "NS"
  ttl     = 300
  records = each.value
}
