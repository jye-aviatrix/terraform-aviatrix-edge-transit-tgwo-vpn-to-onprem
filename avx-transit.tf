module "region1_mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "2.5.1"
  cloud                  = "AWS"
  name                   = "${var.region1_code}-transit"
  region                 = var.region1
  cidr                   = var.region1_transit_cidr
  account                = var.account
  bgp_ecmp               = var.bgp_ecmp
  enable_transit_firenet = var.enable_transit_firenet
  gw_name                = "${var.region1_code}-transit"
  insane_mode            = var.insane_mode
  local_as_number        = var.region1_local_as_number
  instance_size          = var.instance_size
  ha_gw                  = var.ha_gw
  enable_segmentation    = var.enable_segmentation
  hybrid_connection = true # Sign of readiness for TGW connection
}


module "region2_mc_transit" {
  source                 = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version                = "2.5.1"
  cloud                  = "AWS"
  name                   = "${var.region2_code}-transit"
  region                 = var.region2
  cidr                   = var.region2_transit_cidr
  account                = var.account
  bgp_ecmp               = var.bgp_ecmp
  enable_transit_firenet = var.enable_transit_firenet
  gw_name                = "${var.region2_code}-transit"
  insane_mode            = var.insane_mode
  local_as_number        = var.region2_local_as_number
  instance_size          = var.instance_size
  ha_gw                  = var.ha_gw
  enable_segmentation    = var.enable_segmentation
  hybrid_connection = true # Sign of readiness for TGW connection
}
