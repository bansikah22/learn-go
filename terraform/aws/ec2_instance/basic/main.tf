# main.tf
# Generate an RSA 4096-bit private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "${path.module}/var.key_name.pem"
  content  = tls_private_key.rsa_4096.private_key_pem
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name                           
  public_key = tls_private_key.rsa_4096.public_key_openssh  
}

# Retrieve the list of availability zones for the given AWS region
data "aws_availability_zones" "available" {
  state = "available"
}

# resource for EBS volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]  # Use the first available AZ
  size              = 20  # Size in GiB
  type              = "gp2"  # General Purpose SSD
  tags = {
    Name = "prod_dem-ebs-volume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"  # Name of the device on the instance
  volume_id   = aws_ebs_volume.ebs.id  
  instance_id = aws_instance.production_dem.id 
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
  user_data = file("${path.module}/script/setup-dev-environment.sh")
  
  # Tags to identify the EC2 instance
  tags = {
    Name = "production_dem" 
  }
}
