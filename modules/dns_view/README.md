# OCI DNS Views Terraform Module

## Introduction
This Terraform module facilitates the deployment of DNS Views in Oracle Cloud Infrastructure (OCI). DNS Views allow you to create different views of DNS data based on various criteria, such as client subnet, query type, or any other DNS attribute. This module automates the setup process, enabling users to quickly provision DNS Views resources in their OCI environment.

## Usage
To use this module, include it in your Terraform configuration and specify the required input variables. Here's a basic example of how to use the module:

```hcl
module "dns_views" {
  source  = "path/to/modules/dns_view"
  version = "1.0.0"

  tenancy_ocid    = "your_tenancy_ocid"
  compartment     = "your_compartment_name"
  name            = "example_dns_view"
  defined_tags    = {
    Environment = "Production"
    Department = "IT"
  }
  freeform_tags   = {
    CostCenter = "12345"
    Project = "XYZ"
  }
}
```

Replace the values with your specific OCI tenancy OCID, compartment name, DNS view name, and tag definitions.

## Variables
Before using this module, you must configure the required variables. These can be set in a terraform.tfvars file for easy module configuration.

### Required Variables
- `tenancy_ocid`: The OCID of the root compartment.
- `compartment`: The name of the compartment in which the DNS View will be created.
- `name`: The name of the DNS view.

### Optional Variables
- `freeform_tags`: Simple key-value pairs to tag the resources created using freeform tags.
- `defined_tags`: Predefined and scoped to a namespace to tag the resources created using defined tags.

**Note:** If `compartment_id` is provided, it will override the `compartment` variable.

## Outputs
- `id`: The OCID of the DNS View.

You can define additional outputs as needed based on the resources created within the module.

## Notes
- Ensure that you have the necessary IAM permissions to create resources in the specified compartments and VCN.
- Review and customize the module inputs according to your specific requirements.
- For more information on DNS Views in OCI and its configuration options, refer to the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/DNS/Concepts/views.htm).