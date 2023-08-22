module "onprem_mc_spoke" {
  source             = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version            = "1.6.3"
  cloud              = "AWS"
  name               = "${var.onprem_code}-spoke"
  region             = var.onprem_region
  cidr               = var.onprem_spoke_cidr
  account            = var.account
  gw_name            = "${var.onprem_code}-spoke"
  insane_mode        = var.insane_mode
  ha_gw              = var.ha_gw
  transit_gw         = module.onprem_mc_transit.transit_gateway.gw_name
  instance_size = var.instance_size
}
