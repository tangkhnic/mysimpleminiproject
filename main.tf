terraform {
  backend "s3" {
    bucket = "sctp-ce3-tfstate-bucket"
    key ="nic.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "ec2" {
  ami           = "ami-08a52ddb321b32a8c"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  key_name = "KwongHoongKeyPair"
  associate_public_ip_address = "true"
  subnet_id = "subnet-044b09d27aa26415c"
  vpc_security_group_ids = ["sg-0c3f63d5afd6fa587"]
  tags = {
    Name = "nic-amazonlinux2023ami-t2.micro-mysimpleminiproject"
  }
}
resource "aws_instance" "ec2-ansibleserver" {
  ami           = "ami-08a52ddb321b32a8c"  # Amazon Linux 2 LTS
  instance_type = "t2.micro"
  key_name = "KwongHoongKeyPair"
  associate_public_ip_address = "true"
  subnet_id = "subnet-044b09d27aa26415c"
  vpc_security_group_ids = ["sg-0c3f63d5afd6fa587"]
  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install pip -y
sudo python3 -m pip install --user ansible
EOF
  tags = {
    Name = "nic-amazonlinux2023ami-t2.micro-mysimpleminiproject-ansibleserver"
  }
}