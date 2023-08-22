# Create an Aviatrix AWS TGW VPN Connection (dynamic)
resource "aviatrix_aws_tgw_vpn_conn" "region1_tgw_vpn_conn_to_onprem" {
  tgw_name          = aviatrix_aws_tgw.tgwo_region1.tgw_name
  route_domain_name = aviatrix_aws_tgw_network_domain.region1_default.name
  connection_name   = "${var.region1_code}-to-onprem"
  connection_type   = "dynamic"
  public_ip         = module.onprem_mc_transit.transit_gateway.public_ip
  remote_as_number  = module.onprem_mc_transit.transit_gateway.local_as_number
  inside_ip_cidr_tun_1 = "169.254.0.100/30"
  pre_shared_key_tun_1 = "v07vni4mJj8A"
}

# Create an Aviatrix AWS TGW VPN Connection (dynamic)
resource "aviatrix_aws_tgw_vpn_conn" "region2_tgw_vpn_conn_to_onprem" {
  tgw_name          = aviatrix_aws_tgw.tgwo_region2.tgw_name
  route_domain_name = aviatrix_aws_tgw_network_domain.region2_default.name
  connection_name   = "${var.region2_code}-to-onprem"
  connection_type   = "dynamic"
  public_ip         = module.onprem_mc_transit.transit_gateway.public_ip
  remote_as_number  = module.onprem_mc_transit.transit_gateway.local_as_number
  inside_ip_cidr_tun_1 = "169.254.0.104/30"
  pre_shared_key_tun_1 = "v07vni4mJj8A"
}


resource "aviatrix_transit_external_device_conn" "onprem_to_region1_tgw_vpn_conn" {
  vpc_id            = module.onprem_mc_transit.vpc.vpc_id
  connection_name   = "onprem-to-${var.region1_code}"
  gw_name           = module.onprem_mc_transit.transit_gateway.gw_name
  connection_type   = "bgp"
  bgp_local_as_num  = module.onprem_mc_transit.transit_gateway.local_as_number
  bgp_remote_as_num = aviatrix_aws_tgw.tgwo_region1.aws_side_as_number
  pre_shared_key = "v07vni4mJj8A"
  remote_gateway_ip = [for tunnel in aviatrix_aws_tgw_vpn_conn.region1_tgw_vpn_conn_to_onprem.vpn_tunnel_data :   tunnel.vpn_outside_address  if cidrsubnet("169.254.0.100/30", 0, 0) == cidrsubnet("${tunnel.vpn_inside_address}/30", 0, 0)][0]
  local_tunnel_cidr = "169.254.0.102/30"
  remote_tunnel_cidr = "169.254.0.101/30"
}

resource "aviatrix_transit_external_device_conn" "onprem_to_region2_tgw_vpn_conn" {
  vpc_id            = module.onprem_mc_transit.vpc.vpc_id
  connection_name   = "onprem-to-${var.region2_code}"
  gw_name           = module.onprem_mc_transit.transit_gateway.gw_name
  connection_type   = "bgp"
  bgp_local_as_num  = module.onprem_mc_transit.transit_gateway.local_as_number
  bgp_remote_as_num = aviatrix_aws_tgw.tgwo_region2.aws_side_as_number
  pre_shared_key = "v07vni4mJj8A"
  remote_gateway_ip = [for tunnel in aviatrix_aws_tgw_vpn_conn.region2_tgw_vpn_conn_to_onprem.vpn_tunnel_data :   tunnel.vpn_outside_address  if cidrsubnet("169.254.0.104/30", 0, 0) == cidrsubnet("${tunnel.vpn_inside_address}/30", 0, 0)][0]
  local_tunnel_cidr = "169.254.0.106/30"
  remote_tunnel_cidr = "169.254.0.105/30"
}