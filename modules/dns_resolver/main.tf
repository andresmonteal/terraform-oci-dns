########################
# dns resolver
########################

locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-dns"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
  # compartment_id       = try(data.oci_identity_compartments.compartment[0].compartments[0].id, var.compartment_id)
}

resource "oci_dns_resolver" "main" {
    #Required
    resolver_id = data.oci_core_vcn_dns_resolver_association.dns_resolver_association.dns_resolver_id 

    #Optional
    scope = "PRIVATE"

    # attached views aggregation
    dynamic "attached_views" {
      for_each = data.oci_dns_views.dns_views
      content {
        view_id = attached_views.value.views[0].id
      }
    }

    defined_tags  = var.defined_tags
    freeform_tags = local.merged_freeform_tags

    # rules with domain
    dynamic "rules" {
      for_each = can(var.rules.domain) ? { for idx, obj in var.rules.domain : tostring(idx) => obj } : {}
      content {
        action = "FORWARD"
        destination_addresses = lookup(rules.value, "destination_addresses")
        source_endpoint_name = oci_dns_resolver_endpoint.resolver_endpoint[lookup(rules.value, "source_endpoint_name")].name

        #Optional
        client_address_conditions = null
        qname_cover_conditions = lookup(rules.value, "qname_cover_conditions")
      }
    }

   # rules with addresses
    dynamic "rules" {
      for_each = can(var.rules.addresses) ? { for idx, obj in var.rules.addresses : tostring(idx) => obj } : {}
      content {
        action = "FORWARD"
        destination_addresses = lookup(rules.value, "destination_addresses")
        source_endpoint_name = oci_dns_resolver_endpoint.resolver_endpoint[lookup(rules.value, "source_endpoint_name")].name

        #Optional
        client_address_conditions = lookup(rules.value, "client_address_conditions")
        qname_cover_conditions = null
      }
    }
}

resource "oci_dns_resolver_endpoint" "resolver_endpoint" {
    for_each = var.resolver_endpoint_list
    
    #Required
    is_forwarding = each.value.is_forwarding
    is_listening = each.value.is_listening
    name = each.key
    resolver_id = data.oci_core_vcn_dns_resolver_association.dns_resolver_association.dns_resolver_id 
    subnet_id = data.oci_core_subnets.endpoint_subnets[each.key].subnets[0].id
    scope = "PRIVATE"

    #Optional
    endpoint_type = "VNIC"
    forwarding_address = each.value.is_forwarding == true ? each.value.resolver_endpoint_forwarding_address : ""
    listening_address = each.value.is_listening == true ? each.value.resolver_endpoint_listening_address : ""
    nsg_ids = each.value.nsg_name != "" ? [data.oci_core_network_security_groups.network_security_groups[each.key].network_security_groups[0].id] : []
}