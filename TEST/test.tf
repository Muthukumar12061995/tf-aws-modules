module "vpc" {
  source = "../VPC"
  tag-name = "mk-lab"
  vpc-cidr-block = "10.0.0.0/16"
  public-subnets = {
    pub-sub1 = {
      cidr_block = "10.0.1.0/24"
      azs = "us-east-1a"
      map_public_ip_on_launch = true
    }
    pub-sub2 = {
      cidr_block = "10.0.2.0/24"
      azs = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }
}

module "sg" {
  source = "../SG"

  tag_name = "mk-lab"
  vpc-id = module.vpc.vpc_id

  sg-rules = {
    ssh = {
      port = "22"
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}