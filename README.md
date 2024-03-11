# Terraform - 101

<p align="center">
  <a href="#HowToUseThisProject">The Project</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#Lab">Labs</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-license">License</a>
</p>


<p align="justify">The project contain a list of labs developed to enhance my Terraform skills using diverse cloud providers.</p>

## 🚀 The project

Before you start, you should prepare your environment:

## 🛠 Laboratório

<p align="left">[ ] Configure AWS creadentials (IAM)</p>
<p align="left">[ ] Configure AWS cli</p>
<p align="left">[ ] Configure Terraform</p>
<p align="left">[ ] Configure VSCode (plugins Terraform) </p>

Happy coding 😊

[ ] 1 VPC
[ ] 2 Public Subnet with routing to the Internet Gateway
[ ] 2 Private Subnet with routing to the NAT Gateway
[ ] 1 S3 Gateway Endpoint and add to the Public and Private Route Tables
[ ] 1 Application Load Balancer with Listener Port 80, Target group port 80
[ ] 1 Launch Template for EC2 instance – use Amazon Linux AMI
[ ] 1 Auto Scaling group using the Launch Template

* Be sure to properly add security group rules for the ALB and the EC2 instances
** Here’s the script you can add to the EC2 instances to install and run Apache on bootup

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