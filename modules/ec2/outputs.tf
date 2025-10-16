output "instance_ids" {
  value = aws_instance.app[*].id
}

output "instance_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}