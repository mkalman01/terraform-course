output "public_ip" {
  value = aws_eip.web.public_ip
}

output "server_id" {
  value = aws_instance.web.id
}

output "security_group_id" {
  value = aws_security_group.web.id
}
