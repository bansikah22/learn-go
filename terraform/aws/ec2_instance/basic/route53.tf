# route53.tf
# Create a Route 53 Hosted Zone
resource "aws_route53_zone" "main" {
  name = var.domain_name  
}

# Create an A record pointing to the Elastic IP
# Create an A record for the root domain
resource "aws_route53_record" "root_a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name     = ""  # will point to the root domain
  type     = "A"
  ttl      = 300
  records   = [aws_eip.elastic_ip.public_ip]
}

# Create an A record for the www subdomain
resource "aws_route53_record" "www_a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name     = "www"
  type     = "A"
  ttl      = 300
  records   = [aws_eip.elastic_ip.public_ip]
}

# Create a wildcard A record for subdomains
resource "aws_route53_record" "wildcard_a_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "*"
  type    = "A"
  ttl     = 300
  records = [aws_eip.elastic_ip.public_ip]
}
