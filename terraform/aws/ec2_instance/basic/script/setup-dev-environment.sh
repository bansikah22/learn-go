#!/bin/bash

# Update the package list and upgrade existing packages
sudo apt update -y
sudo apt upgrade -y

# Install Nginx web server (latest version)
sudo apt install nginx -y

# Disable and stop Nginx service to avoid port conflicts with Traefik
sudo systemctl disable nginx
sudo systemctl stop nginx

# Optionally comment out the default server block in Nginx configuration
sudo sed -i 's/listen 80;/#listen 80;/' /etc/nginx/sites-available/default
sudo sed -i 's/listen \[::\]:80;/#listen [::]:80;/' /etc/nginx/sites-available/default

# Reload Nginx to apply changes
sudo systemctl reload nginx

# Install Docker and necessary dependencies (latest stable version)
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo systemctl enable docker  
sudo systemctl start docker   
sudo usermod -aG docker $USER 

# Install Docker Compose (latest stable version)
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version      

# Install Node.js (latest LTS version)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs -y
node -v                       
npm -v                        

# Install Git for version control
sudo apt install git -y

# Install Python and pip (useful for automation/scripting)
sudo apt install python3 python3-pip -y
python3 --version             
pip3 --version                

# Clean up and remove unnecessary packages to free up space
sudo apt autoremove -y

# Format the volume (ext4)
sudo mkfs -t ext4 /dev/xvdf

# Create a mount point directory
sudo mkdir -p /mnt/ebs

# Mount the volume
sudo mount /dev/xvdf /mnt/ebs

# Ensure persistence across reboots
echo "/dev/xvdf /mnt/ebs ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab

# Clone the repository containing the Docker Compose files
git clone https://github.com/bansikah22/shop-app.git

# Navigate to the production directory
cd shop-app/docker-compose/production

# Start the Docker Compose services in detached mode
docker-compose up -d

# Print a confirmation message after setup
echo "Development environment setup complete."
