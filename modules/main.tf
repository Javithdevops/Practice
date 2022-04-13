resource "aws_security_group" "sg" {
  name = var.sg_name
  description = "For test instance"
  ingress {
    from_port = 23
    protocol  = "TCP"
    to_port   = 23
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon-lnx" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "instance" {
  ami = data.aws_ami.amazon-lnx.id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  tags = {
    Name: var.servertag
  }
  depends_on = [aws_security_group.sg]
}