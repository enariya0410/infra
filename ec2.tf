data "aws_vpc" "main" {
  filter{
    name = "tag:Name"
    values = ["terrvpc"]
  }
}
data "aws_subnet" "main" {
  filter{
    name = "tag:Name"
    values = ["terrsubnet"]
  }
}

data "aws_security_group" "allow_tls" {
  filter{
    name = "tag:Name"
    values = ["allow_tls"]
  }
}
# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "Main"
#   }
# }

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = data.aws_vpc.main.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 8080
#     to_port          = 8080
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instancetype
  associate_public_ip_address = true
  key_name = "test123"
  vpc_security_group_ids = [data.aws_security_group.allow_tls.id]
  subnet_id =data.aws_subnet.main.id
  


  tags = {
    Name = "ekkuec23"
  }
}