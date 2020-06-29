to do: make this look good
# Terraform Refresh

This is a basic terraform project which creates the following:

* a VPC
* two subnets (one private and one public)
* two instances (one in each subnet)
* a internet gateway to allow communication outside the VPC
* a NAT gateway to allow instances in the private subnet to communicate with the internet (but not vise versa)
* two route tables (for the public and private subnets)
* two NACLs (same as above)
* two security groups (one for public instancesm, one for private)

## Requirements:

 * Terraform: instructions on installation [here](https://learn.hashicorp.com/terraform/getting-started/install.html)

 * AWS access and secret keys: instructions on generating [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey)

 * your ip addresss (just search my ip address in google)

you will need to find your ip address (just search my ip address in google)