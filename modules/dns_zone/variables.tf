// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
  type        = string
  default     = null
}

variable "compartment_id" {
  description = "compartment id where to create all resources"
  type        = string
  default     = null
}

variable "compartment" {
  description = "compartment name where to create all resources"
  type        = string
  default     = null
}

variable "name" {
  description = "(Required) The name of the zone."
  type        = string
}

variable "freeform_tags" {
  description = "simple key-value pairs to tag the resources created using freeform tags."
  type        = map(string)
  default     = null
}

variable "defined_tags" {
  description = "predefined and scoped to a namespace to tag the resources created using defined tags."
  type        = map(string)
  default     = null
}

variable "zone_type" {
  description = "(Required) The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
  type        = string
  default     = "PRIMARY"
}

variable "scope" {
  description = "(Optional) Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone."
  type        = string
  default     = null
}

variable "dns_records" {
  description = " If a specified record does not exist, it will be created. If the record exists, then it will be updated to represent the record in the body of the request."
  type        = any
  default     = []
}

variable "view_id" {
  description = "(Optional) The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view."
  type        = string
  default     = null
}