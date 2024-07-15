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

