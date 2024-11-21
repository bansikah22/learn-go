# variables.tf
# Define a variable for AWS access key
variable "aws_access_key" {
  description = "AWS access key"  
  type        = string            
}

# Define a variable for AWS secret key
variable "aws_secret_key" {
  description = "AWS secret key"   
  type        = string             
}

# Define a variable for the AWS region
variable "aws_region" {
  description = "AWS region"      
  type        = string            
  default     = "eu-central-1"    
}

# Define a variable for the key pair name
variable "key_name" {
  description = "Name of the key pair"  
  type        = string                  
  default     = "auto-generated-key"    
}

# Define a variable for the EC2 instance type
variable "instance_type" {
  description = "Type of the EC2 instance"  
  type        = string                     
  default     = "t2.micro"                 
}

# Define a variable for the AMI ID (Amazon Machine Image)
variable "ami_id" {
  description = "AMI ID for the EC2 instance"  
  type        = string                        
  default     = "ami-09042b2f6d07d164a"                
}

# Define a variable for the domain name
variable "domain_name" {
  description = "The domain name for Route 53"
  type        = string
  default = "bansikahadorsys.com"
}