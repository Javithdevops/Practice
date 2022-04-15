resource "aws_vpc" "mynet" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mainvpc"
  }
}

resource "aws_subnet" "pubsubnet1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.mynet.id
  availability_zone = element(var.az, 0)
  tags = {
    Name = "pub_subnet1"
  }
}

resource "aws_subnet" "pubsubnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.mynet.id
  availability_zone = element(var.az, 1)
  tags = {
    Name = "pub_subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mynet.id
  tags = {
    Name = "mainigw"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.mynet.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "pubass1" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id = aws_subnet.pubsubnet1.id
}

resource "aws_route_table_association" "pubass2" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id = aws_subnet.pubsubnet2.id
}

resource "aws_eip" "ip" {
  vpc = true
}

resource "aws_nat_gateway" "ng" {
  subnet_id = aws_subnet.pubsubnet1.id
  allocation_id = aws_eip.ip.id
  tags = {
    Name = "Natgtwy"
  }
}

resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.mynet.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ng.id
  }
}

resource "aws_subnet" "prisubnet1" {
  vpc_id = aws_vpc.mynet.id
  cidr_block = "10.0.3.0/24"
  availability_zone = element(var.az, 0)
  tags = {
    Name = "pri_subnet1"
  }
}

resource "aws_subnet" "prisubnet2" {
  vpc_id = aws_vpc.mynet.id
  cidr_block = "10.0.4.0/24"
  availability_zone = element(var.az, 1)
  tags = {
    Name = "pri_subnet2"
  }
}

resource "aws_route_table_association" "priass1" {
  route_table_id = aws_route_table.prirt.id
  subnet_id = aws_subnet.prisubnet1.id
}

resource "aws_route_table_association" "priass2" {
  route_table_id = aws_route_table.prirt.id
  subnet_id = aws_subnet.prisubnet2.id
}