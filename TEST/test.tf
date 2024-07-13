module "custom-vpc-mk-lab" {
  source = "../VPC"
  tag_name = "mk-lab"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnets = {
    subnet1 = {
      cidr_block ="10.0.1.0/24"
      azs = "us-east-1a"
    }
    subnet2 = {
      cidr_block = "10.0.2.0/24"
      azs = "us-east-1b"
    }
  }
}