## Types of IAC Tools

#### Configuration Management
- Ansible
- Puppet
- SaltStack

### notes
- These tools are designed to install and manage software on already existing systems or infrastructure.

- Maintain Standard Structure

- Version Control

- Idempotent
---

### Server Templating
- Docker
- Packer(HashiCorp)
- Vagrant

### Notes
- Pre Installed Software and Dependencies
- Virtual Machine or Docker images
- Immutable Infrastructure

---
### Provisioning Tools
- Terraform(HashiCorp)
- CloudFormation(AWS)
### Notes
- Deploy Immutable Infrastructure resources
- Servers, Databases, Network Components etc
- Multiple Providers

---

## Terraform
- Opensource
- Multiple Providers support
- Manages Infrastrustures, Databases, Network Components etc
- Uses hcl which is the HashiCorp Configuration Language
- Syntax is declarative: manages code from the current to the desired state

### Terraform Providers
- Physical Machines
- VMware
- AWS 
- GCP
- AZURE

These are just a few , there are more than 100 providers.

---
### Exmaple code for provisioning on aws
```h
resource "aws_instance" "webserver"{
    ami           = "ami-images-name"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance"{
    bucket = "aws_s3_bucket-name"
    tags = {
        Description: "Finance and Payroll"
    }
}

resource "aws_iam_user" "admin_user"{
    name = "bansikah"
    tags = {
        Description: "Team Leader"
    }
}

```
---
- Terraform works in 3 stages
```bash
init -> plan -> apply
```
---
### A Resource
- A resource in Terraform represents a component of your infrastructure, such as a physical server, a virtual machine, a DNS record, or an S3 bucket. Resources have attributes that define their properties and behaviors, such as the size and location of a virtual machine or the domain name of a DNS record.
### A State 
- A state is the blueprint of the infrastructure deployed by terraform
---
## Terraform Installation
```bash
wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip

unzip terraform_0.13.0_linux_amd64.zip

mv terraform /usr/local/bin

terraform version

alias terraform="tf" or add in bashrc for it to persist changes
```

---
## HCL Basics
- hcl files consist of blocks and arguments
```hcl
<block> <parameters> {
    key1: value1
    key2: value2
}
```
- A block contains information about a infrastucture platform
```tf
$mkdir /root/terraform-local-file
$ cd /root/terraform-local-file
```
- create a `local.tf` file
```local.tf
resource "local_file" "pet"{
    filename = "/root/pets.txt"
    content = "We love pets!"
}
```
- Explanation:
```bash
block name -> resource
local=provider file=resource : Resource type -> local_file
Resource Name -> pet
Arguments:{filename -> /root/pets.txt
content -> "We love pets!"}
```
- Execution:
```bash
tf init-> downloads and installs plugins for our tf configuration for our providers
tf plan
tf apply
tf show: to see details of the resource that we just created.
tf destroy: to destroy all the configuration or put down the infrastructure
```
---
### Using terraform Providers
#### Official Providers
- AWS
- Google Cloud
- Azure
- Local

#### Verified Providers
- bigip
- heroku
- digitalOcean

#### Community Providers
- activedirectory
- ucloud
- netapp-gcp
---

### Configuration Directory
The Terraform Configuration Directory contains all necessary files for defining infrastructure, including .tf files for resource definitions, variable files, and modules. It also holds the .terraform/ directory (for provider plugins) and state files, if applicable.

Example Directory Structure:
```bash
my-terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── .terraform/
```
---
### Using Multiple Providers and Resources
```h
resource "local_file" "pet" {
    filename = "./pets.txt"
    content = "We Love pets!"
    file_permission = "0700"
}

resource "local_file" "cat" {
    filename = "./cats.txt"
    content = "We love cats!"
    #file_permission = "0600"
}
  
resource "random_pet" "my-pet" {
  prefix = "Mrs"
  separator = "."
  length = "1"
}
```
---
### Variables
Terraform Variables enable you to parameterize your configurations, enhancing flexibility and reusability. They allow you to define inputs that can be customized without modifying the core infrastructure code.
```h
# variables.tf
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

# main.tf
provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleInstance"
  }
}

```
### Understanding the variables block
- The variables block accepts 3 different parameters
- `default` parameter
- `type` parameter(option) and 
- `description` parameter  optional

- variable types are `string`, `number`, `boolean`, `list`, `map`, `object`, `turple` and `any`

### 1. String
A sequence of characters.
```h
variable "instance_name" {
  type    = string
  default = "my-instance"
}
```
### 2. Number
Numeric values, either integers or floats.
```h
variable "instance_count" {
  type    = number
  default = 3
}
```
### 3. Boolean
True or false values 
```h
variable "enable_logging" {
  type    = bool
  default = true
}
```
### 4. Any
Accept any data type
```h
variable "tags" {
  type    = any
  default = {
    environment = "production"
    team        = "devops"
  }
}
```
### 5. List
A sequence of values of the same type.
```h
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
```
### 6. Map
A collection of key-value pairs, where keys are strings.
```h
variable "instance_tags" {
  type = map(string)
  default = {
    Name        = "my-instance"
    Environment = "production"
  }
}
```
### 7. Object
A complex data structure with specified attributes.
```h
variable "instance_config" {
  type = object({
    instance_type = string
    ami           = string
    count         = number
  })
  default = {
    instance_type = "t2.micro"
    ami           = "ami-12345678"
    count         = 1
  }
}
```
### 8. Tuple
A sequence of values of different types.
```h
variable "server_info" {
  type    = tuple([string, number, bool])
  default = ["web-server", 2, true]
}
```

### Terraform Variable Definition Precedence
Terraform determines variable values based on a defined precedence, from highest to lowest. This hierarchy allows for flexible and dynamic configurations.

#### Precedence Order:
1. Command-Line Flags (`-var` and `-var-file`)
2. Environment Variables (`TF_VAR_ prefix`)
3. `.auto.tfvars` and `.tfvars` Files
D4. efault Values in Configuration

**Examples:**
1. Command-Line Flags:
```bash
terraform apply -var="region=us-west-2"
```
2. Environment Variables:
```bash
export TF_VAR_region="us-east-1"
terraform apply
```
3. `.auto.tfvars` File:
```bash
# terraform.auto.tfvars
region = "eu-central-1"
```
4. Default Value in `variables.tf`:
```h
variable "region" {
  type    = string
  default = "ap-southeast-1"
}
```
### Explanation:
- Command-Line Flags have the highest precedence and override all other methods.
- Environment Variables (TF_VAR_<VARIABLE_NAME>) take precedence over files and defaults.
- .auto.tfvars and .tfvars Files are automatically loaded and override default values.
- Default Values in the variable definitions are used only if no other sources provide a value.
