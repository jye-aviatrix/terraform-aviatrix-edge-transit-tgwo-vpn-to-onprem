module "onprem_mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "2.5.1"
  cloud                  = "AWS"
  name                   = "${var.onprem_code}-transit"
  region                 = var.onprem_region
  cidr                   = var.onprem_transit_cidr
  account                = var.account
  bgp_ecmp               = var.bgp_ecmp
  enable_transit_firenet = var.enable_transit_firenet
  gw_name                = "${var.onprem_code}-transit"
  insane_mode            = var.insane_mode
  local_as_number        = var.onprem_local_as_number
  instance_size          = var.instance_size
  ha_gw                  = var.ha_gw
  enable_segmentation    = var.enable_segmentation
  hybrid_connection = true # Sign of readiness for TGW connection
}