terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">=5.39.0"
    }
  }
  required_version = ">= 1.0.0"
}