module "dns_resolver" {
  source = "../../modules/dns_resolver"

  tenancy_ocid          = var.tenancy_ocid
  vcn_compartment_name  = var.vcn_compartment_name
  vcn_display_name      = var.vcn_display_name

  # Optional
  attached_views            = var.attached_views
  resolver_endpoint_list    = var.resolver_endpoint_list
  rules                     = var.rules

}