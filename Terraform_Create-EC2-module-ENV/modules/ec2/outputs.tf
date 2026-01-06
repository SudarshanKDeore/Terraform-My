output "ec2_public_ip" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.this[*].public_ip
}
