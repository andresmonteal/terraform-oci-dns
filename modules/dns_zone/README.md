# OCI DNS Zone Terraform Module

## Introduction
This Terraform module deploys DNS Zones and corresponding RRsets in Oracle Cloud Infrastructure (OCI). It enables users to manage DNS resources efficiently, automating the provisioning process for DNS zones and records within OCI.

## Usage
To use this module, include it in your Terraform configuration and specify the required input variables. Here's a basic example of how to use the module:

```hcl
module "dns_zone" {
  source  = "path/to/modules/dns_zone"
  version = "1.0.0"

  tenancy_ocid    = "your_tenancy_ocid"
  compartment     = "your_compartment_name"
  name            = "example_dns_zone"

  scope     = "your_scope"
  view_id   = "your_view_id"
  zone_type = "your_zone_type"

  dns_records = [
    {
        domain = "domain1"
        rtype = "rtype1"
        rdata = ["rdata1"]
        ttl = "ttl1"
    },
    {
        domain = "domain2"
        rtype = "rtype2"
        rdata = ["rdata2","rdata3"]
        ttl = "ttl2"
    }
  ]

  defined_tags   = {
    Environment = "Production"
    Department = "IT"
  }
  freeform_tags  = {
    CostCenter = "12345"
    Project = "XYZ"
  }

}
```

Replace the values with your specific OCI tenancy OCID, compartment name, DNS Zone name, scope, associated view, DNS Records and tag definitions.

## Variables
Before using this module, you must configure the required variables. These can be set in a terraform.tfvars file for easy module configuration.

### Required Variables
- `tenancy_ocid`: The OCID of the root compartment.
- `compartment`: The name of the compartment in which the DNS Zone will be created.
- `name`: The name of the DNS Zone.

### Optional Variables
- `compartment_id`: Compartment ID where to create the DNZ Zone.
- `freeform_tags`: Simple key-value pairs to tag the resources created using freeform tags.
- `defined_tags`: Predefined and scoped to a namespace to tag the resources created using defined tags.
- `zone_type`: The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones.
- `scope`: Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone.
- `dns_records`: If a specified record does not exist, it will be created. If the record exists, then it will be updated to represent the record in the body of the request. This should be formatted as an array of items, where each item is a map containing the following attributes:
    - `domain`: (Required) The domain name where the record can be located.
    - `rtype`: (Required) The canonical name for the record's type, such as A or CNAME.
    - `rdata`: (Required) An array with the record's data.
    - `ttl`: (Required) The Time To Live for the record, in seconds.

- `view_id`: The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view.

**Note:** If `compartment_id` is provided, it will override the `compartment` variable.

## Outputs
- `id`: The OCID of the DNS Zone.

You can define additional outputs as needed based on the resources created within the module.

## Notes
- Ensure that you have the necessary IAM permissions to create resources in the specified compartments and VCN.
- Review and customize the module inputs according to your specific requirements.
- For more information on DNS Views in OCI and its configuration options, refer to the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/DNS/Concepts/dnszonemanagement.htm).