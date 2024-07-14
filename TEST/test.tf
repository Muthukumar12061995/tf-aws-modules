module "custom-vpc-mk-lab" {
  source = "../VPC"
  tag-name = "mk-lab"
  vpc-cidr-block = "10.0.0.0/16"
  public-subnets = {
    subnet1 = {
      cidr_block ="10.0.1.0/24"
      azs = "us-east-1a"
      map_public_ip_on_launch = true
    }
  }
}

module "custom-ec2-mk-lab" {
  source = "../EC2"
  ec2-info = {
    cicd = {
      ami = "ami-0a0e5d9c7acc336f1"
      instance_type = "t2.micro"
      ssh_acces = true
    }
  }
  subnet = module.custom-vpc-mk-lab.public_subnets.subnet1.id


}