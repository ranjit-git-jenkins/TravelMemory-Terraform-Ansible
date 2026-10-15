output "web_public_ip" { value = aws_instance.web.public_ip }
output "web_private_ip" { value = aws_instance.web.private_ip }
output "db_private_ip" { value = aws_instance.db.private_ip }
output "ssh_web_example" { value = "ssh -i /path/to/key.pem ubuntu@${aws_instance.web.public_ip}" }
