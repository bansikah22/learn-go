# Output the public IP address of the EC2 instance
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"  # Description of the output (for documentation)
  value       = aws_instance.production_dem.public_ip  # Get the public IP from the EC2 instance
}

# Output the path to the private key file generated for the EC2 instance
output "private_key_path" {
  description = "Path to the private key file"  # Description of the output
  value       = local_file.private_key.filename  # Return the filename of the private key file
}

# Output the ID of the VPC
output "vpc_id" {
  description = "The ID of the VPC"  # Description of the output
  value       = aws_vpc.main_vpc.id  # Get the ID of the VPC created earlier
}

# Output the ID of the subnet where the EC2 instance is located
output "subnet_id" {
  description = "The ID of the Subnet"  # Description of the output
  value       = aws_subnet.public_subnet.id  # Get the ID of the public subnet
}

# Output the ID of the Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"  # Description of the output
  value       = aws_internet_gateway.igw.id  # Get the ID of the Internet Gateway attached to the VPC
}
