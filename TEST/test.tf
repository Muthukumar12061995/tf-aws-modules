module "vpc" {
  source = "../VPC"

  tag_name = "mk-lab"
  cidr_block = "10.0.0.0/16"
  public_subnets = [ "10.0.1.0/24" ]
  azs = "us-east-1a"
}