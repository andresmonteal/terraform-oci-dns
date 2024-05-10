variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaakq76gncimczz6erne4ly7nqc7zkh7qjy3532mu6h6lapedat7tua"
}

variable "compartment" {
  description = "compartment name where to create all resources"
  type        = string
  default     = "LuisAvila"
}

variable "zone_name" {
  description = "(Required) The name of the DNS zone."
  type        = string
  default = "dnstests.com"
}

variable "scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone."
  type        = string
  default     = "PRIVATE"
}

variable "dns_records" {
  description = " If a specified record does not exist, it will be created. If the record exists, then it will be updated to represent the record in the body of the request."
  type        = any
  default     = []
}

variable "view_name" {
  description = "(Required) The name of the DNS view."
  type        = string
  default = "view_prueba"
}