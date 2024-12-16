resource "aws_vpc" "main" {
 cidr_block = "10.150.0.0/16"
 
 tags = {
   Name = "VPC"
 }
}

resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 tags = {
   Name = "Pub-Sub-${count.index + 1}"
 }
}
 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 availability_zone = element(var.azs, count.index)
 tags = {
   Name = "Prv-Sub-${count.index + 1}"
 }
}

resource "aws_internet_gateway" "igw" {
 vpc_id = aws_vpc.main.id
  
 tags = {
   Name = "IGW01"
 }
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.main.id
  
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.igw.id
 }
  
 tags = {
   Name = "VPC01-RT-PUB"
 }
}


resource "aws_route_table_association" "public_subnet_association" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_rt.id
}
