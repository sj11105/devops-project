# Cloud Automation Using Terraform and AWS

This is a DevOps project that uses Docker, Kubernetes, Jenkins, and Terraform.

First run terraform, by going into the directory and init and apply.

Compress-Archive -Path .\app\* -DestinationPath flask_app.zip 
or
Compress-Archive -Path .\app\* -DestinationPath flask_app.zip -Update


scp -i "C:\Users\saksh\.ssh\your-key.pem" .\flask_app.zip ubuntu@13.233.94.218:~

ssh -i "C:\Users\saksh\.ssh\your-key.pem" ubuntu@13.233.94.218

sudo apt update && sudo apt install unzip docker.io -y

unzip flask_app.zip

sudo docker build -t flask-app .

sudo docker run -d -p 5000:5000 flask-app

http://13.233.94.218:5000/#   C l o u d - a u t o m a t i o n - T e r r a f o r m  
 #   C l o u d - a u t o m a t i o n  
 