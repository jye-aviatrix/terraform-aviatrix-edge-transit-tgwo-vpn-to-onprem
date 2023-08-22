module "region1_mc_spoke" {
  source             = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version            = "1.6.3"
  cloud              = "AWS"
  name               = "${var.region1_code}-spoke"
  region             = var.region1
  cidr               = var.region1_spoke_cidr
  account            = var.account
  gw_name            = "${var.region1_code}-spoke"
  insane_mode        = var.insane_mode
  ha_gw              = var.ha_gw
  transit_gw         = module.region1_mc_transit.transit_gateway.gw_name
  instance_size = var.instance_size
}



module "region2_mc_spoke" {
  source             = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version            = "1.6.3"
  cloud              = "AWS"
  name               = "${var.region2_code}-spoke"
  region             = var.region2
  cidr               = var.region2_spoke_cidr
  account            = var.account
  gw_name            = "${var.region2_code}-spoke"
  insane_mode        = var.insane_mode
  ha_gw              = var.ha_gw
  transit_gw         = module.region2_mc_transit.transit_gateway.gw_name
  instance_size = var.instance_size
}