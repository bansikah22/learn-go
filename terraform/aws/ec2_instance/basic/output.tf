# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"  
  value       = aws_instance.production_dem.public_ip  
}

# Output the path to the private key file generated for the EC2 instance
output "private_key_path" {
  description = "Path to the private key file"  
  value       = local_file.private_key.filename  
}

# Output the ID of the VPC
output "vpc_id" {
  description = "The ID of the VPC"  
  value       = aws_vpc.main_vpc.id  
}

# Output the ID of the subnet where the EC2 instance is located
output "subnet_id" {
  description = "The ID of the Subnet"  
  value       = aws_subnet.public_subnet.id  
}

# Output the ID of the Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"  
  value       = aws_internet_gateway.igw.id  
}
