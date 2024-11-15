## Necessary Steps to Set Up an EC2 Instance
- **1 VPC (Virtual Private Cloud):** The network in which your EC2 instance will reside.
- **2 Subnet:** A segment of your VPC where you can place your EC2 instances.
- **3 Internet Gateway:** Allows your VPC to connect to the internet.
- **4 Route Table:** Determines how traffic is directed in your VPC.
- **5 Security Group:** Acts as a virtual firewall for your instance to control inbound and outbound traffic.
- **6 Key Pair:** SSH key pair for securely connecting to your instance.
- **7 IAM Role (Optional):** Provides your instance with permissions to access other AWS services (like S3, CloudWatch, etc.).
- **8 Data (Optional):** Script to run at instance launch for setting up the environment (installing packages, etc.).


```bash
ssh -i "auto-generated-key.pem" ubuntu@35.158.96.126
chmod 400 auto-generated-key.pem if you encounter problems with permissions

destroy ec2 machine 
terraform destroy -auto-approve
```
Below is a Terraform configuration that includes all the necessary components for a fully functional EC2 instance.