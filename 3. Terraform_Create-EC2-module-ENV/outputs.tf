output "ec2_public_ip" {
  description = "Public IPs from EC2 module"
  value       = module.ec2.ec2_public_ip
}
