module "instance_launch" {
  source = "../modules"
  sg_name = var.sg_name
  instance_type = var.instance_type
  servertag = var.servertag
  netcidr = var.vpc_cidr
  tag = var.vpctag
  pubsubnet1_cidr = var.pubnet1
  pubsubnet2_cidr = var.pubnet2
  prisubnet1_cidr = var.prinet1
  prisubnet2_cidr = var.prinet2
  subnettag_pub = var.pubsubnettag
  subnettag_pri = var.prisubnettag
  az = var.az
}