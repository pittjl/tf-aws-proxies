module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
  proxy_port = var.proxy_port
  ip_address = var.ip_address
}

module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  ip_address = var.ip_address
  instance_count = var.instance_count
  vpc        = module.networking.vpc
  sg_pub_id  = module.networking.sg_pub_id
  key_name   = module.ssh-key.key_name
}

