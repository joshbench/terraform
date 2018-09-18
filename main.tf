#AWS
provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}

    # need variables for key and secret ?????


#VPC

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

resource "aws_instance" "main_ec2" {
  ami           = "${var.OPAL_AMI}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true

  tags {
    Name = "${var.OPAL_ENV}"
  }
}

#OUTPUTS


output "EC2_name_tag" {
  value = "${aws_instance.main_ec2.tags["Name"]}"
}

output "EC2_public_ip" {
  value = "${aws_instance.main_ec2.public_ip}"
}

output "EC2_subnet_id" {
  value = "${aws_instance.main_ec2.subnet_id}"
}