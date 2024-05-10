# Zone
module "dns_zone" {
  source = "../../modules/dns_zone"

  tenancy_ocid    = var.tenancy_ocid
  compartment     = var.compartment
  name            = var.zone_name

  scope           = var.scope
  view_id         = module.dns_view.id
  dns_records     = var.dns_records
}

# View
module "dns_view" {
  source = "../../modules/dns_view"

  tenancy_ocid  = var.tenancy_ocid
  compartment   = var.compartment
  name          = var.view_name
}