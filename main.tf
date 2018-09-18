#VARIABLES

    # OPAL_ENV == (name of vpc and ec2)
    # OPAL_AMI == (name of ami for ec2 inst)

#AWS
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}

    # Need creds to point to ~/.aws/credentials
    # need variables for key and secret ?????
    # need variable for region


#VPC

    # Public subnet
    # 10.0.0.0/16 for vpc
    # "Name" tag == OPAL_ENV

resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.OPAL_ENV}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.main_vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-west-2a"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main_vpc.id}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public.id}"
}


#EC2
# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"


resource "aws_instance" "main_ec2" {
  ami           = "${var.OPAL_AMI}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet.id}"

  tags {
    Name = "${var.OPAL_ENV}"
  }
}

    # in public subnet
    # "Name" tag == OPAL_ENV
    # AMI == OPAL_AMI

#OUTPUTS

    # List EC2 name tag
    # List EC2 public IP
    # List Public Subnet ID