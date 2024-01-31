terraform {
  backend "s3" {
    bucket = "my-state-bucket-u4109"
    dynamodb_table = "my-state-bucket-lock-table"
    key = "terraform.tfstate"
    encrypt = true
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "my_vpc" {
  source = "./modules/vpc/"

  vpc_name = "my_vpc"
  my_vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "sg" {
  source = "./modules/security-group/"

  sg_name        = "public-sg"
  sg_description = "Security group public"

  vpc_id = module.my_vpc.vpc_id

  sg_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  sg_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

module "jenkins" {
  source = "./modules/ec2-instance"
  
  instance_ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.my_vpc.public_subnet_ids[0]
  security_groups_name = module.sg.my_sg_id
  instance_name = "jenkins-instance"
  instance_env = "dev"
  instance_role = "jenkins"
}

module "app-server" {
  source = "./modules/ec2-instance"
  
  instance_ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.my_vpc.public_subnet_ids[1]
  security_groups_name = module.sg.my_sg_id
  instance_name = "app-instance"
  instance_env = "dev"
  instance_role = "app"
}

module "monitoring-server" {
  source = "./modules/ec2-instance"
  
  instance_ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.my_vpc.public_subnet_ids[0]
  security_groups_name = module.sg.my_sg_id
  instance_name = "monitoring-instance"
  instance_env = "dev"
  instance_role = "monitoring"
}