// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

module "dns" {
  source = "../"

  for_each = var.dns

  tenancy_ocid = var.tenancy_ocid
  compartment  = each.value["compartment"]
  name         = each.key
  dns_records  = lookup(each.value, "dns_records", [])
}