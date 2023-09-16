provider "aws" {
  region = "us-east-1" 
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" 
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-east-1a"  
  map_public_ip_on_launch = true
}


resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}


resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "my_instance" {
  ami           = "ami-xxxxxxxxxxxxxxxxx" 
  instance_type = "t2.micro"             
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.ssh.name]

  tags = {
    Name = "MyVM"
  }
}


output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
