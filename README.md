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

requirements:

you will need to find your ip address (just search my ip address in google)