#!/bin/bash -x
# Startup script to install Java 
sudo apt update
sudo apt install -y openjdk-17-jre
# Verify Java installation
java -version
# Startup script to install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins
# Startup script to enable & start Jenkins daemon
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
echo "Jenkins installation completed"
