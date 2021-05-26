provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntirevpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "ntire_vpc_tf"
  }
}
resource "aws_subnet" "my_subnet" {
  count = 4
  vpc_id = aws_vpc.ntirevpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.subnetazs[count.index]

  tags = {
    Name = var.subnets_names[count.index]
  }
}
resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.ntirevpc.id

  tags = {
    Name = "gateway_tf"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ntirevpc.id
  tags = {
    Name = "public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ntirevpc.id
  tags = {
    Name = "private"
  }
}

resource "aws_route_table_association" "webassociations" {
  count = 2
  route_table_id = aws_route_table.public.id
  subnet_id =  aws_subnet.my_subnet[count.index].id
}
resource "aws_route_table_association" "appassociations" {
 count = 2
 route_table_id = aws_route_table.private.id
 subnet_id = aws_subnet.my_subnet[count.index + 2].id
}
resource "aws_security_group" "websg" {
  name = "websg"
  description = "allow ssh and tcp ports"
  vpc_id = aws_vpc.ntirevpc.id

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "port 22 open"
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "port 80 open"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }

  tags = {
    Name = "allow ssh and http ports"
  }
}
