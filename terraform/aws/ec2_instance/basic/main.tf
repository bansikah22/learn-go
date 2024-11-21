# main.tf
# Generate an RSA 4096-bit private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name                           
  public_key = tls_private_key.rsa_4096.public_key_openssh  
}

# Allocate an Elastic IP
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.production_dem.id
}

# Provision an AWS EC2 instance
resource "aws_instance" "production_dem" {
  ami                    = var.ami_id                 
  instance_type          = var.instance_type          
  key_name               = aws_key_pair.key_pair.key_name 
  subnet_id              = aws_subnet.public_subnet.id  
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id] 

  # User data script to set up a development environment on the EC2 instance
  user_data = "${file("setup-dev-environment.sh")}"
  
  # Tags to identify the EC2 instance
  tags = {
    Name = "production_dem" 
  }
}