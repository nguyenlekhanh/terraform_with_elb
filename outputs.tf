output "db_host" {
  value = aws_db_instance.main.address
}

output "bastion_host" {
  value = aws_instance.bastion.public_dns
}

#### can not get output from another file other (load_balancer.tf) than main.tf
# output "api_endpoint" {
#   value = aws_lb.api.dns_name
# }

# output "api_endpoint" {
#   value = aws_route53_record.app.fqdn
# }
