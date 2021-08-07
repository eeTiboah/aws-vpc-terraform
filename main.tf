provider "aws" {
    region = "eu-west-2"
}

variable "cidr_block" {}
variable "subnet_cidr_block" {}
variable "availability_zone" {}
variable "env_prefix"{}

resource "aws_vpc" "app-vpc" {
    cidr_block = var.cidr_block
    tags = {
        Name = "${var.env_prefix}-vpc"
    }
}

resource "aws_subnet" "app-subnet-1" {
    vpc_id = aws_vpc.app-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    tags = {
        Name = "${var.env_prefix}-subnet"
    }
}

resource "aws_internet_gateway" "app-igw" {
    vpc_id = aws_vpc.app-vpc.id
    tags = {
        Name = "${var.env_prefix}-igw"
    }
}

resource "aws_route_table" "app-route-table" {
    vpc_id = aws_vpc.app-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.app-igw.id
    }
    tags = {
        Name = "${var-env_prefix}-rtb"
    }
}