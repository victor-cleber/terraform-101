# Terraform - 101

<p align="center">
  <a href="#HowToUseThisProject">The Project</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#Lab">Lab</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-license">License</a>
</p>


<p align="justify">The project contain a list of labs developed to enhance my Terraform skills using diverse cloud providers.</p>

## 🚀 The project

Before you start, you should prepare your environment:

<p align="left">[ ] Configure AWS creadentials (IAM)</p>
<p align="left">[ ] Configure AWS cli</p>
<p align="left">[ ] Configure Terraform</p>
<p align="left">[ ] Configure VSCode (plugins Terraform) </p>

Happy coding 😊

## 🛠 Lab

<p align="left">[ ] 1 VPC</p>
<p align="left">[ ] 2 Public Subnets with routing to the Internet Gateway</p>
<p align="left">[ ] 2 Private Subnets with routing to the NAT Gateway</p>
<p align="left">[ ] 1 S3 Gateway Endpoint and add to the Public and Private Route Tables</p>
<p align="left">[ ] 1 Application Load Balancer with Listener Port 80, Target group port 80</p>
<p align="left">[ ] 1 Launch Template for EC2 instance – use Amazon Linux AMI</p>
<p align="left">[ ] 1 Auto Scaling group using the Launch Template</p>
</p>
<p align="left">* Be sure to properly add security group rules for the ALB and the EC2 instances</p>
<p align="left">** Here’s the script you can add to the EC2 instances to install and run Apache on bootup</p>

Amazon Linux 2
```bash
#!/bin/bash
yum repolist
yum install httpd -y
systemctl enable httpd
echo "It Works" > /var/www/html/index.html
systemctl start httpd
```
Linux (Debian)
```bash
  #!/bin/bash -xe
  apt update
  apt install nginx
  sudo ufw allow 'Nginx HTTP'  
```
## :memo: License

This project is under an GNU General Public License v3.0. See more details in [LICENSE](LICENSE) for more information.

---