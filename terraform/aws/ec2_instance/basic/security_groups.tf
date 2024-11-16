# Define a security group for EC2 instances in the VPC
resource "aws_security_group" "ec2_security_group" {
  vpc_id = aws_vpc.main_vpc.id  # Attach the security group to the main VPC

  # Ingress rule to allow SSH (port 22) access from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 22                  # Allow connections on port 22 (SSH)
    to_port     = 22                  # Allow connections on port 22 (SSH)
    protocol    = "tcp"               # Use TCP protocol
    cidr_blocks = ["0.0.0.0/0"]       # Allow from any IP address (0.0.0.0/0)
  }

  # Ingress rule to allow HTTP (port 80) access from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 80                  # Allow connections on port 80 (HTTP)
    to_port     = 80                  # Allow connections on port 80 (HTTP)
    protocol    = "tcp" 
    description = "HTTP"              # Use TCP protocol
    cidr_blocks = ["0.0.0.0/0"]       # Allow from any IP address (0.0.0.0/0)
  }

ingress {
  from_port = 8082
  to_port   = 8082
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  # Ingress rule to allow HTTPS (port 443) access from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 443                 # Allow connections on port 443 (HTTPS)
    to_port     = 443                 # Allow connections on port 443 (HTTPS)
    protocol    = "tcp"               # Use TCP protocol
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]       # Allow from any IP address (0.0.0.0/0)
  }

  # Egress rule to allow all outbound traffic (to any destination)
  egress {
    from_port   = 0                   # Allow all outbound traffic
    to_port     = 0                   # Allow all outbound traffic
    protocol    = "-1"                # Allow all protocols (no restriction)
    cidr_blocks = ["0.0.0.0/0"]       # Allow traffic to any destination (0.0.0.0/0)
  }

  # Tag for identifying the security group
  tags = {
    Name = "ec2_security_group"       # Assign a name tag to the security group
  }
}
