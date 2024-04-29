resource "tls_private_key" "ssh-key-pair" {
    algorithm = "RSA"
}

resource "aws_key_pair" "generated_key" {
    key_name = "ssh-key-pair"
    public_key = "${tls_private_key.ssh-key-pair.public_key_openssh}"
    depends_on = [
        tls_private_key.ssh-key-pair
     ]
    
}

resource "local_file" "ssh-key"{
    content = "${tls_private_key.ssh-key-pair.private_key_pem}"
    filename = "aws_key_pair.pem"
    file_permission = "0400"
    depends_on = [
         tls_private_key.ssh-key-pair 
    ]
}
