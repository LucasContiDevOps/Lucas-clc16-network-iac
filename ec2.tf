# # AMI mais recente do Amazon Linux 2023 (x86_64)
# data "aws_ami" "al2023" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.*-x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# # Security Group: HTTP 80 liberado para a internet
# resource "aws_security_group" "web" {
#   name        = "security-group-web-clc16_tf"
#   description = "Libera HTTP 80 para a EC2 com Apache"
#   vpc_id      = aws_vpc.clc_vpc.id # <- AJUSTE

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Toda saida (necessario para o dnf baixar o httpd)"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "sg-web-clc16_tf"
#   }
# }

# # EC2 na subnet pública 1a com Apache via user_data
# resource "aws_instance" "web" {
#   ami                         = data.aws_ami.al2023.id
#   instance_type               = "t3.micro"                # use t2.micro se o lab exigir
#   subnet_id                   = aws_subnet.public_subnet_1c.id  # <- AJUSTE
#   vpc_security_group_ids      = [aws_security_group.web.id]
#   associate_public_ip_address = true
#   user_data_replace_on_change = true

#   user_data = <<-EOF
#     #!/bin/bash
#     dnf install -y httpd
#     systemctl enable --now httpd
#     cat > /var/www/html/index.html <<'HTML'
#     <!DOCTYPE html>
#     <html lang="pt-BR">
#       <head><meta charset="UTF-8"><title>CLC 16</title></head>
#       <body>
#         <h1>CHEGUEI ATÉ AQUI - Lucas Conti Nunes - CLC 16</h1>
#       </body>
#     </html>
#     HTML
#   EOF

#   tags = {
#     Name = "ec2-apache-clc16_tf"
#   }
# }
