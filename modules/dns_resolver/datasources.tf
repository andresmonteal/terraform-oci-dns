data "oci_core_vcn_dns_resolver_association" "dns_resolver_association" {
    #Required
    vcn_id = data.oci_core_vcns.vcns.virtual_networks[0].id
}

data "oci_core_vcns" "vcns" {
    #Required
    compartment_id = data.oci_identity_compartments.vcn_compartment_id.compartments[0].id

    #Optional
    display_name = var.vcn_display_name
    state = "AVAILABLE"
}

data "oci_identity_compartments" "vcn_compartment_id" {
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  state                     = "ACTIVE"
  compartment_id_in_subtree = true
  name                      = var.vcn_compartment_name
}

data "oci_identity_compartments" "endpoint_subnet_compartment_ids" {
  for_each = var.resolver_endpoint_list
  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  state                     = "ACTIVE"
  compartment_id_in_subtree = true
  name                      = each.value.endpoint_subnet_compartment
}

data "oci_core_subnets" "endpoint_subnets" {
  for_each = var.resolver_endpoint_list
  compartment_id = data.oci_identity_compartments.endpoint_subnet_compartment_ids[each.key].compartments[0].id
  display_name   = each.value.endpoint_subnet_name
  vcn_id = data.oci_core_vcns.vcns.virtual_networks[0].id
}

data "oci_core_network_security_groups" "network_security_groups" {
    for_each = var.resolver_endpoint_list

    #Optional
    compartment_id = data.oci_identity_compartments.vcn_compartment_id.compartments[0].id
    display_name = each.value.nsg_name
    state = "AVAILABLE"
    vcn_id = data.oci_core_vcns.vcns.virtual_networks[0].id
}

data "oci_dns_views" "dns_views" {
  for_each = { for idx, obj in var.attached_views : tostring(idx) => obj }
  #Required
  compartment_id = data.oci_identity_compartments.dns_views_compartment_ids[each.key].compartments[0].id
  scope = "PRIVATE"

  #Optional
  display_name = each.value.view_name
  state = "ACTIVE"
}

data "oci_identity_compartments" "dns_views_compartment_ids" {
  for_each = { for idx, obj in var.attached_views : tostring(idx) => obj }

  compartment_id            = var.tenancy_ocid
  access_level              = "ANY"
  state                     = "ACTIVE"
  compartment_id_in_subtree = true
  name                      = each.value.compartment_name
}