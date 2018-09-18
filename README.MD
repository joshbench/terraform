AWS VPC and EC2 instance using Terraform
=============

## Installation

* install [Terraform](https://www.terraform.io/) and add it to your PATH
* clone this repository
* cd into this repository
* run `terraform init`

## AWS CLI

You have two options here: 
* You can use credentials stored in ~/.aws/credentials on your local machine through aws cli
OR
* You can specify your own access key and secret key using the `aws_access_key` and `aws_secret_key` variables in variables.tf

## Using Terraform

This is a simple setup, you should only need to run the following commands from this directory:

* `terraform plan`
* `terraform apply`

When you are done, simply run a destroy to clean up

* `terraform destroy`
