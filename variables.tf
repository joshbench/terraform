#variable "aws_access_key" {}
#variable "aws_secret_key" {}
#variable "aws_key_path" {}

variable "aws_region" {
    default = "us-west-2"
}
variable "OPAL_ENV" {
    default = "test-env"
}

variable "OPAL_AMI" {
    default = {
        us-west-2 = "ami-6cd6f714" # Amazon Linux
    }
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}