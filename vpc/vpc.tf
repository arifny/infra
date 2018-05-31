# Internet VPC
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "vpc - ${terraform.workspace}"
    }
}


# Subnets
resource "aws_subnet" "public-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "public-1-${terraform.workspace}"
    }
}
resource "aws_subnet" "public-2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "public-2-${terraform.workspace}"
    }
}
resource "aws_subnet" "public-3" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"


    tags {
        Name = "public-3-${terraform.workspace}"
    }
}
resource "aws_subnet" "private-1" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "private-1-${terraform.workspace}"
    }
}
resource "aws_subnet" "private-2" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "private-2-${terraform.workspace}"
    }
}
resource "aws_subnet" "private-3" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "private-3-${terraform.workspace}"
    }
}

# Internet GW
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
	Name = "gw-${terraform.workspace}"
    }
}

# route tables
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "public-1-${terraform.workspace}"
    }
}

# route associations public
resource "aws_route_table_association" "public-1-a" {
    subnet_id = "${aws_subnet.public-1.id}"
    route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "public-2-a" {
    subnet_id = "${aws_subnet.public-2.id}"
    route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "public-3-a" {
    subnet_id = "${aws_subnet.public-3.id}"
    route_table_id = "${aws_route_table.public.id}"
}
