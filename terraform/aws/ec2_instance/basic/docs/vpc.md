### Create a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16
```bash
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"  # CIDR block for the VPC (IP range for the VPC)
  
  tags = {
    Name = "main_vpc"  # Tag the VPC with a name for easy identification
  }
}
```

### Create a public subnet within the above VPC with a CIDR block of 10.0.1.0/24
```bash
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id  # Associate the subnet with the previously created VPC
  cidr_block              = "10.0.1.0/24"        # CIDR block for the subnet (sub-range of VPC)
  map_public_ip_on_launch = true                  # Automatically assign public IPs to instances in this subnet
  availability_zone       = "eu-central-1a"       # Availability zone for the subnet

  tags = {
    Name = "public_subnet"  # Tag the subnet with a name for easy identification
  }
}
```

### Create an Internet Gateway (IGW) and associate it with the main VPC
```bash
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id  # Attach the internet gateway to the main VPC

  tags = {
    Name = "main_igw"  # Tag the internet gateway with a name for easy identification
  }
}
```
### Create a Route Table for the public subnet to route traffic to the Internet Gateway
```bash
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
```

### Associate the public subnet with the public route table
```bash
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id      # The subnet to associate with the route table
  route_table_id = aws_route_table.public_route.id  # The route table to associate with the subnet
}
```

# Key Concepts:
#### VPC (Virtual Private Cloud):
 A virtual network within AWS that allows you to launch AWS resources like EC2 instances, RDS databases, etc. The CIDR block defines the range of private IP addresses that can be used within the VPC.


### Subnet:
 A subnet is a range of IP addresses in your VPC. In this case, the subnet is public, meaning resources within it can have public IPs and connect to the internet. A subnet also resides within a specific Availability Zone.


### Internet Gateway (IGW):
 An IGW allows communication between instances in your VPC and the internet. This is necessary for public subnets that require internet access.


### Route Table:
 A route table contains a set of rules, known as routes, that determine where network traffic is directed. The "0.0.0.0/0" route points all outbound traffic from the public subnet to the IGW.


### Route Table Association:
 This associates a route table with a subnet to ensure that traffic from the subnet follows the defined routes.

### Best Practices:

### Always tag your resources with meaningful names for better organization and management.
- Use smaller CIDR blocks (e.g., /24) for subnets to avoid overlapping IP ranges in larger environments.
- Public subnets should have direct internet access via an Internet Gateway, while private subnets may have restricted internet access through NAT Gateways or other configurations.
