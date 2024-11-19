# Create a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"  # CIDR block for the VPC (IP range for the VPC)
  
  tags = {
    Name = "main_vpc"  
  }
}

# Create a public subnet within the above VPC with a CIDR block of 10.0.1.0/24
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id  
  cidr_block              = "10.0.1.0/24"        
  map_public_ip_on_launch = true                  
  availability_zone       = "eu-central-1a"       

  tags = {
    Name = "public_subnet"  
  }
}

# Create an Internet Gateway (IGW) and associate it with the main VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id  

  tags = {
    Name = "main_igw"  
  }
}

# Create a Route Table for the public subnet to route traffic to the Internet Gateway
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main_vpc.id  

  # Default route to allow outbound traffic to the internet (0.0.0.0/0 means all destinations)
  route {
    cidr_block = "0.0.0.0/0"       
    gateway_id = aws_internet_gateway.igw.id  
  }

  tags = {
    Name = "public_route"  # Tag the route table with a name for easy identification
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id      
  route_table_id = aws_route_table.public_route.id  
}
