# Create a Private Key RSA de 4096 bits
resource "tls_private_key" "windows_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a Key Pair in AWS using the previus public key created
resource "aws_key_pair" "windows_kp" {
  key_name   = "windows-kp-ec2"
  public_key = tls_private_key.windows_key.public_key_openssh
}

# Save your private  (.pem) locally
resource "local_file" "private_key_pem" {
  filename        = "${aws_key_pair.windows_kp.key_name}.pem"
  content         = tls_private_key.windows_key.private_key_pem
  file_permission = "0600"
}

# Get the latest Windwows 2022 version
data "aws_ami" "windows_2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}

# Security Group RDP (3389)
resource "aws_security_group" "allow_rdp" {
  name        = "allow_rdp"
  description = "Allow RDP traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    #cidr_blocks = [local.my_ip_cidr]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 1. Adopt the Default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "sa-east-1a" # Change to your preferred AZ

  tags = {
    Name = "Default Subnet for sa-east-1a"
  }
}

# Create EC2 Windows instance
resource "aws_instance" "windows_instance" {
  ami                         = data.aws_ami.windows_2022.id
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.windows_kp.key_name
  subnet_id                   = aws_default_subnet.default_az1.id
  vpc_security_group_ids      = [aws_security_group.allow_rdp.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  lifecycle {
    ignore_changes = [user_data]
  }

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  tags = {
    Name = "Windows IRPF"
  }
}
output "password_data" {
  value = aws_instance.windows_instance.password_data
}

data "http" "my_ip" {
  #url = "https://ifconfig.me/ip"
  url = "https://ipv4.icanhazip.com"
}

locals {
  # Add /32 CIDR suffix for a single IP address rule
  my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2-role.name
}

resource "aws_iam_role" "ec2-role" {
  name               = "ec2_role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "aws-managed" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",

  ])

  role       = aws_iam_role.ec2-role.name
  policy_arn = each.value
}