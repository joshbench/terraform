variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "aws_region" {
    default = "us-west-2"
}
variable "OPAL_ENV" {
    default = "test-env"
}

variable "OPAL_AMI" {
    default = "ami-6cd6f714" # Amazon Linux
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}