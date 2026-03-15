# 🚀 Terraform EC2 Static Website Deployment

This project uses Terraform to automatically create an EC2 instance on Amazon Web Services, install the Apache web server, and upload a static `index.html` webpage.

---

## 📸 Project Screenshot (Preview)
Here is the output of the deployed website:

![Webpage Screenshot](images/Terra-proj1.png)

---
### 2️⃣ Terraform Apply Output
![Screenshot 2](images/Terra-proj2.png)

## 📘 Project Overview

This project demonstrates how to:

- Create an EC2 instance using Terraform
- Upload a static HTML file to the server
- Install & start Apache automatically
- Serve a webpage using the server’s public IP

---

## 🧩 How the Project Works (Step-by-Step Explanation)

### **1️⃣ Terraform creates an EC2 instance**
Terraform uses the `aws_instance` resource to create a virtual machine on AWS.

What happens here:
- You choose an AMI (Amazon Linux)
- You select an instance type (`t2.micro`)
- You assign a subnet, key pair, and security group
- Terraform launches the server and tags it as `Apollo1`

Once applied, you get:
- A running EC2 instance  
- A public IP address you can use to access the website  

---

### **2️⃣ Uploading the HTML file**
The `null_resource` is used with a file provisioner.

What it does:
- Takes `index.html` from your local machine
- Uploads it to `/tmp/index.html` on the EC2 instance
- Connects using SSH via your key file

Trigger used:

html_hash = filesha1("${path.module}/index.html")
This tells Terraform:

If the HTML file changes, upload it again.

3️⃣ Installing Apache (web server)

Terraform runs remote commands to:

Install Apache

Start the Apache service

Enable Apache on boot

Create /var/www/html

Move index.html to the Apache folder

Apply correct permissions

Your EC2 instance becomes a small web server.

4️⃣ Website goes live

After placing the HTML file in:

/var/www/html/index.html

Apache serves it automatically.

Open your browser and visit:

http://<your-ec2-public-ip>

Your webpage loads instantly. 🎉

