module "transit-peering" {
  source  = "terraform-aviatrix-modules/mc-transit-peering/aviatrix"
  version = "1.0.8"

  transit_gateways = [
    module.region1_mc_transit.transit_gateway.gw_name,
    module.region2_mc_transit.transit_gateway.gw_name
  ]

  excluded_cidrs = [
  ]
}