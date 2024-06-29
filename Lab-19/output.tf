output "server_id" {
  value = aws_instance.myserver.id
}

output "server_public_ip" {
  value = aws_instance.myserver.public_ip
}
