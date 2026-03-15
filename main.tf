resource "aws_instance" "Apollo" {
  ami                         = "ami-0ced6a024bb18ff2e"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-05377554746258903"
  key_name                    = "Terraform-key"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-090044b1ec7d1b667"]

  tags = {
    Name = "Apollo1"
  }
}
resource "null_resource" "upload_html" {

  # ⭐ Re-run when index.html changes
  triggers = {
    html_hash = filesha1("${path.module}/index.html")
  }

  # Upload into /tmp
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("Terraform-key.pem")
      host        = aws_instance.Apollo.public_ip
    }
  }

  # Move it into Apache directory
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo mkdir -p /var/www/html",
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("Terraform-key.pem")
      host        = aws_instance.Apollo.public_ip
    }
  }
}
