######## 1 main(vpc) resource
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name = "main-vpc"
    }
}
########### 2 subnet resource
resource "aws_subnet" "public" {
    vpc_id            = aws_vpc.main.id
    count = length(var.public_subnet_cidrs)
    cidr_block        = var.public_subnet_cidrs[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

######### 3 internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

###### 4 route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-rt"
    }
}

########## 5 route table assosciation
resource "aws_route_table_association" "public_rta" {
    count          = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public_rt.id
}