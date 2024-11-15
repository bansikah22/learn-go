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
  user_data = <<-EOF
    #!/bin/bash

    # Update the package list and upgrade existing packages
    sudo apt update -y
    sudo apt upgrade -y

    # Install Nginx web server
    sudo apt install nginx -y
    sudo systemctl enable nginx  # Enable Nginx to start on boot
    sudo systemctl start nginx   # Start Nginx immediately

    # Install Docker and necessary dependencies
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install docker-ce docker-ce-cli containerd.io -y
    sudo systemctl enable docker  # Enable Docker to start on boot
    sudo systemctl start docker   # Start Docker immediately
    sudo usermod -aG docker $USER # Add the current user to the Docker group for non-root access

    # Install Docker Compose (version 2.31.1)
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.31.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version      # Verify Docker Compose installation

    # Install Node.js (version 18.x) and npm
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install nodejs -y
    node -v                       # Check Node.js version
    npm -v                        # Check npm version

    # Install Git for version control
    sudo apt install git -y

    # Remove unnecessary packages to free up space
    sudo apt autoremove -y

    # Print a confirmation message after setup
    echo "Development environment setup complete."
  EOF

  # Tags to identify the EC2 instance
  tags = {
    Name = "production_dem" # Tag the instance with a name for easy identification
  }
}
