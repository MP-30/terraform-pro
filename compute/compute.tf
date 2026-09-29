resource "aws_instance" "jenkins-server" {
  ami = "ami-01a00762f46d584a1"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public-subnet-1.id
  tags = {
    Name = "jenkins-server"
  }
  key_name = "l"
  associate_public_ip_address = true
  user_data = file("install-jenkins.sh")
  vpc_security_group_ids = [aws_security_group.sg-allow-http-ssh.id]
  user_data_replace_on_change =  true
}

resource "aws_security_group" "sg-allow-http-ssh" {
  name = "allow-http-ssh"
  description = "Allow HTTP and SSH traffic"
  vpc_id = aws_vpc.development-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins-ip" {
  value = aws_instance.jenkins-server.public_ip
}
output "jenkins-mac-name" {
  value = aws_instance.jenkins-server.id
}