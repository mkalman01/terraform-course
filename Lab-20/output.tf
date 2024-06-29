output "instance_ids" {
  value = aws_instance.server[*].id
}

output "instance_public_ips" {
  value = aws_instance.server[*].public_ip
}

output "iam_users_arn" {
  value = aws_iam_user.user[*].arn
}

output "bastion_public_ip" {
  value = var.create_bastion == "Yes" ? aws_instance.bastion_server[0].public_ip : null
}
