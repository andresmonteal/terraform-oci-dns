// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {
  description = "(Required) (Updatable) The OCID of the root compartment."
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

variable "vcn_compartment_name" {
  description = "(Required) The compartment's name of the vcn."
  type        = string
}

variable "vcn_display_name" {
  description = "(Required) The display names's of the vcn."
  type        = string
}

variable "rules" { 
  description = "(Optional) (Updatable) The collection of rules used for the DNS resolver."
  default     = {}
  type        = map(any)
}

variable "attached_views" {
  description = "(Optional) (Updatable) The collection of attached views to include in the DNS resolver."
  default     = []
  type        = list(any)
}

variable "resolver_endpoint_list" {
  description = "(Optional) (Updatable) The collection of resolver endpoint list to include in the DNS resolver."
  default     = {}
  type        = map(any)
}