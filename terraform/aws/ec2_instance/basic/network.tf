# Create a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"  # CIDR block for the VPC (IP range for the VPC)
  
  tags = {
    Name = "main_vpc"  # Tag the VPC with a name for easy identification
  }
}

# Create a public subnet within the above VPC with a CIDR block of 10.0.1.0/24
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id  # Associate the subnet with the previously created VPC
  cidr_block              = "10.0.1.0/24"        # CIDR block for the subnet (sub-range of VPC)
  map_public_ip_on_launch = true                  # Automatically assign public IPs to instances in this subnet
  availability_zone       = "eu-central-1a"       # Availability zone for the subnet

  tags = {
    Name = "public_subnet"  # Tag the subnet with a name for easy identification
  }
}

# Create an Internet Gateway (IGW) and associate it with the main VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id  # Attach the internet gateway to the main VPC

  tags = {
    Name = "main_igw"  # Tag the internet gateway with a name for easy identification
  }
}

# Create a Route Table for the public subnet to route traffic to the Internet Gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main_vpc.id  # Attach the route table to the main VPC

  # Default route to allow outbound traffic to the internet (0.0.0.0/0 means all destinations)
  route {
    cidr_block = "0.0.0.0/0"       # Destination for the route (any IP address)
    gateway_id = aws_internet_gateway.igw.id  # Route to the Internet Gateway
  }

  tags = {
    Name = "public_route"  # Tag the route table with a name for easy identification
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id      # The subnet to associate with the route table
  route_table_id = aws_route_table.public_route.id  # The route table to associate with the subnet
}
