# Define a variable for AWS access key
variable "aws_access_key" {
  description = "AWS access key"  # A unique identifier used to authenticate with AWS
  type        = string            # The type of value expected is a string
}

# Define a variable for AWS secret key
variable "aws_secret_key" {
  description = "AWS secret key"   # The secret key used in combination with the access key for authentication
  type        = string             # The type of value expected is a string
}

# Define a variable for the AWS region
variable "aws_region" {
  description = "AWS region"      # The AWS region to deploy resources in ('eu-central-1')
  type        = string            # The type of value expected is a string
  default     = "eu-central-1"    # Default region if no value is provided, can be overridden
}

# Define a variable for the key pair name
variable "key_name" {
  description = "Name of the key pair"  # Name for the EC2 key pair (used for SSH access)
  type        = string                  # The type of value expected is a string
  default     = "auto-generated-key"    # Default name for the key pair if none is provided
}

# Define a variable for the EC2 instance type
variable "instance_type" {
  description = "Type of the EC2 instance"  # Type of the EC2 instance (e.g., t2.micro, t2.medium)
  type        = string                     # The type of value expected is a string
  default     = "t2.micro"                 # Default EC2 instance type, can be modified based on requirements
}

# Define a variable for the AMI ID (Amazon Machine Image)
variable "ami_id" {
  description = "AMI ID for the EC2 instance"  # The AMI ID to launch the EC2 instance
  type        = string                        # The type of value expected is a string
  default     = "ami-09042b2f6d07d164a"                # Default AMI ID for the instance (ensure it is valid for your region)
}

