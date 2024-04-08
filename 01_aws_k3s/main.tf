module "vpc" {
  source = "./modules/01_vpc"
}

module "subnet" {
  source = "./modules/02_subnet"
  vpc_id = module.vpc.vpc_id
}

module "igw" {
  source = "./modules/03_igw"
  vpc_id = module.vpc.vpc_id
}

module "ngw" {
  source = "./modules/04_ngw"
  #vpc_id = module.vpc.vpc_id
  pub_sub_id = module.subnet.pub_sub_id
}

module "route_table" {
  source = "./modules/05_route_table"
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
  ngw_id = module.ngw.ngw_id
}

module "subnet_association" {
  source      = "./modules/06_subnet_association"
  pub_sub_id  = module.subnet.pub_sub_id
  pub_rt_id   = module.route_table.pub_rt_id
  pvt_sub1_id = module.subnet.pvt_sub1_id
  pvt_sub2_id = module.subnet.pvt_sub2_id
  pvt_sub3_id = module.subnet.pvt_sub3_id
  pvt_rt_id   = module.route_table.pvt_rt_id
}

module "security_group" {
  source = "./modules/07_security_groups"
  vpc_id = module.vpc.vpc_id
}

module "keypair" {
  source = "./modules/08_keypair"
  public_key = file("./ssh/k3s_cluster_key.pub")
}

module "instances" {
  source                 = "./modules/09_instances"
  pub_sub_id             = module.subnet.pub_sub_id
  pvt_sub1_id            = module.subnet.pvt_sub1_id
  pvt_sub2_id            = module.subnet.pvt_sub2_id
  pvt_sub3_id            = module.subnet.pvt_sub3_id
  bastion_sg_id          = module.security_group.bastion_sg_id
  controlplane_sg_id     = module.security_group.controlplane_sg_id
  k3s_cluster_keypair_id = module.keypair.k3s_cluster_keypair_id
}