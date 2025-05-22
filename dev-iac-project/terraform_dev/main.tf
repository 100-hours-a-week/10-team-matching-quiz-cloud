module "vpc" {
  source     = "../modules/vpc"
  cidr_block = "172.16.0.0/16"
  name       = "dev-vpc"
}

module "nat" {
  source = "../modules/nat"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "jenkins_ec2" {
  source        = "../modules/ec2_jenkins_ansible"
  ami           = var.ami
  instance_type = "t3.medium"
  subnet_id     = module.vpc.public_subnet_id
  key_name      = var.key_name
}

# 예시: 필요한 모듈 추가 가능
