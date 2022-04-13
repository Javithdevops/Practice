module "instance_lunch" {
  source = "../modules"
  sg_name = var.sg_name
  instance_type = var.instance_type
  servertag = var.servertag
}