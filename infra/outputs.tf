output "public_ip" {
  description  = "Public IP address of the EC2 Instance"
  value  = aws_instance.ec2.public_ip
}
