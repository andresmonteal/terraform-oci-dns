########################
# dns
########################

locals {
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-dns"
  }
  merged_freeform_tags = merge(var.freeform_tags, local.default_freeform_tags)
  compartment_id       = try(data.oci_identity_compartments.compartment[0].compartments[0].id, var.compartment_id)
  dns_records          = { for idx, obj in var.dns_records : tostring(idx) => obj }
}

resource "oci_dns_zone" "main" {
  #Required
  compartment_id = local.compartment_id
  name           = var.name
  zone_type      = var.zone_type

  #Optional
  defined_tags  = var.defined_tags
  freeform_tags = local.merged_freeform_tags
  scope         = var.scope

  view_id = var.view_id
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}

resource "oci_dns_rrset" "main" {
  for_each = local.dns_records
  #for_each = var.dns_records
  #Required
  zone_name_or_id = oci_dns_zone.main.id
  domain          = "${can(each.value["domain"]) ? "${each.value["domain"]}." : ""}${var.name}" #each.key
  rtype           = each.value["rtype"]

  #Optional
  compartment_id = local.compartment_id
  dynamic "items" {
    for_each = { for idx, obj in local.dns_records[each.key].rdata : tostring(idx) => obj }

    content {
      #Required
      domain = "${can(each.value["domain"]) ? "${each.value["domain"]}." : ""}${var.name}" #each.key
      rdata  = items.value
      rtype  = each.value["rtype"]
      ttl    = lookup(each.value, "ttl", 86400)
    }
  }
  scope   = var.scope
  view_id = var.view_id

  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}