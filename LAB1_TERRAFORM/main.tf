provider "aws" {
  region     = "ap-southeast-2"
  access_key = "Your access_key" #Must fill
  secret_key = "Your private key"
}
module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  vpc_name            = "lab1"
  public_subnet_cidr  = "10.0.0.0/24"
  public_subnet_az    = "ap-southeast-2a"
  private_subnet_cidr = "10.0.1.0/24"
  private_subnet_az   = "ap-southeast-2a"
}

module "nat_gateway" {
  source             = "./modules/nat_gateway"
  public_subnet_id   = module.vpc.public_subnet_id
  internet_gateway_id = module.vpc.internet_gateway_id
}

module "route_table" {
  source             = "./modules/route_table"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_id     = module.nat_gateway.nat_gateway_id
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "instances" {
  source           = "./modules/instances"
  ami              = "ami-040e71e7b8391cae4"
  instance_type    = "t2.micro"
  key_name         = "Your key pair" #Must fill
  public_sg_id     = module.security_groups.public_sg_id
  private_sg_id    = module.security_groups.private_sg_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
}