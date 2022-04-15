resource "aws_vpc" "mynet" {
  cidr_block = var.netcidr
  tags = {
    Name = var.tag
  }
}

resource "aws_subnet" "pub1" {
  cidr_block = var.pubsubnet1_cidr
  vpc_id     = aws_vpc.mynet.id
  availability_zone = element(var.az, 0)
  tags = {
    Name = element(var.subnettag_pub, 0)
  }
}

resource "aws_subnet" "pub2" {
  cidr_block = var.pubsubnet2_cidr
  vpc_id     = aws_vpc.mynet.id
  availability_zone = element(var.az, 1)
  tags = {
    Name = element(var.subnettag_pub, 1)
  }
}

resource "aws_subnet" "pri1" {
  cidr_block = var.prisubnet1_cidr
  vpc_id     = aws_vpc.mynet.id
  availability_zone = element(var.az, 0)
  tags = {
    Name = element(var.subnettag_pri, 0)
  }
}

resource "aws_subnet" "pri2" {
  cidr_block = var.prisubnet2_cidr
  vpc_id     = aws_vpc.mynet.id
  availability_zone = element(var.az, 1)
  tags = {
    Name = element(var.subnettag_pri, 1)
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mynet.id
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
  subnet_id = aws_subnet.pub1.id
}

resource "aws_route_table_association" "pubass2" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id = aws_subnet.pub2.id
}

resource "aws_eip" "ip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  subnet_id = aws_subnet.pub1.id
  allocation_id = aws_eip.ip.id
}

resource "aws_route_table" "prirt" {
  vpc_id = aws_vpc.mynet.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "priass1" {
  route_table_id = aws_route_table.prirt.id
  subnet_id = aws_subnet.pri1.id
}

resource "aws_route_table_association" "priass2" {
  route_table_id = aws_route_table.prirt.id
  subnet_id = aws_subnet.pri2.id
}