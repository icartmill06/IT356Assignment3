# Find an available Availability Zone
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the VPC
resource "aws_vpc" "school_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "IT356-School-VPC"
  }
}

# Create the external subnet
resource "aws_subnet" "external" {
  vpc_id                  = aws_vpc.school_vpc.id
  cidr_block              = var.external_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "External-Subnet"
    Type = "Public"
  }
}

# Create the internal subnet
resource "aws_subnet" "internal" {
  vpc_id                  = aws_vpc.school_vpc.id
  cidr_block              = var.internal_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "Internal-Subnet"
    Type = "Private"
  }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "school_igw" {
  vpc_id = aws_vpc.school_vpc.id

  tags = {
    Name = "IT356-Internet-Gateway"
  }
}

# Create external route table
resource "aws_route_table" "external_rt" {
  vpc_id = aws_vpc.school_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.school_igw.id
  }

  tags = {
    Name = "External-Route-Table"
  }
}

# Create internal route table
resource "aws_route_table" "internal_rt" {
  vpc_id = aws_vpc.school_vpc.id

  tags = {
    Name = "Internal-Route-Table"
  }
}

# Associate external subnet with its route table
resource "aws_route_table_association" "external_assoc" {
  subnet_id      = aws_subnet.external.id
  route_table_id = aws_route_table.external_rt.id
}

# Associate internal subnet with its route table
resource "aws_route_table_association" "internal_assoc" {
  subnet_id      = aws_subnet.internal.id
  route_table_id = aws_route_table.internal_rt.id
}