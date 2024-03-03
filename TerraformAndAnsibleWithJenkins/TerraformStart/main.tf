provider "aws" {
  region = "us-east-1"
}

module "jenkins_vpc" {
  source = "./modules/vpc/"

  vpc_name = "jenkins-vpc"
  my_vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24"]
}

module "public_jenkins_sg" {
  source = "./modules/security-group/"

  sg_name        = "public-jenkins-sg"
  sg_description = "Security group public"

  vpc_id = module.jenkins_vpc.vpc_id

  sg_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8080
      to_port     = 8080
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
  instance_type = "t2.medium" // TODO medium
  subnet_id = module.jenkins_vpc.public_subnet_ids[0]
  security_groups_name = module.public_jenkins_sg.my_sg_id
  instance_name = "jenkins-instance"
  instance_env = "dev"
  instance_role = "jenkins"
}

resource "local_file" "hosts_cfg" {
  content = templatefile("inventory.tmpl", {
    jenkins_host = module.jenkins.instance_public_ip
  })

  filename = "../AnsibleStart/inventory.ini"
}