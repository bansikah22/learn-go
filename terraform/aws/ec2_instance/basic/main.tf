# Generate an RSA 4096-bit private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name                           # Name of the key pair (provided via variable)
  public_key = tls_private_key.rsa_4096.public_key_openssh  # Use the generated RSA public key
}

# Save the generated private key to a local file for SSH access
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem # Content of the private key in PEM format
  filename = "${var.key_name}.pem"                   # Filename for the private key (e.g., my-key.pem)
}

# Provision an AWS EC2 instance
resource "aws_instance" "production_dem" {
  ami                    = var.ami_id                 # AMI ID for the instance (provided via variable)
  instance_type          = var.instance_type          # Instance type (e.g., t2.micro) provided via variable
  key_name               = aws_key_pair.key_pair.key_name # Key pair for SSH access
  subnet_id              = aws_subnet.public_subnet.id  # Associate the instance with a specific subnet
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id] # Attach security group(s)

  # User data script to set up a development environment on the EC2 instance
  user_data = file("scripts/setup-dev-environment.sh")
  # Tags to identify the EC2 instance
  tags = {
    Name = "production_dem" # Tag the instance with a name for easy identification
  }
}
