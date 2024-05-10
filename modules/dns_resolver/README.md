# OCI DNS Resolver Terraform Module

## Introduction
This Terraform module facilitates the deployment of a DNS Resolver along with its DNS Resolver Endpoints in Oracle Cloud Infrastructure (OCI). It automates the setup process, enabling users to quickly provision DNS Resolver resources in their OCI environment.

## Usage
To use this module, include it in your Terraform configuration and specify the required input variables. Here's a basic example of how to use the module:

```hcl
module "dns_resolver" {
  source  = "path/to/modules/dns_resolver"
  version = "1.0.0"

  tenancy_ocid         = "your_tenancy_ocid"
  vcn_compartment_name = "your_vcn_compartment_name"
  vcn_display_name     = "your_vcn_display_name"
  resolver_endpoint_list = {
    "endpoint1" = {
      is_forwarding = true
      is_listening = false
      resolver_endpoint_forwarding_address = "forwarding_address"
      resolver_endpoint_listening_address = ""
      nsg_name = "nsg_name1"
    }
    "endpoint2" = {
      is_forwarding = false
      is_listening = true
      resolver_endpoint_forwarding_address = ""
      resolver_endpoint_listening_address = "listening_address"
      nsg_name = "nsg_name2"
    }
  }
  attached_views = [
    {
      view_name = "view_name1"
      compartment_name = "view_compartment_name1"
    },
    {
      view_name = "view_name2"
      compartment_name = "view_compartment_name2"
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
  rules = {
    domain = [
      {
        destination_addresses = ["destination_address1", "destination_address2"]
        source_endpoint_name = "source_endpoint_name1"
        qname_cover_conditions = ["qname_cover_condition1"]
        client_address_conditions = []
      },
      {
        destination_addresses = ["destination_address3", "destination_address4"]
        source_endpoint_name = "source_endpoint_name2"
        qname_cover_conditions = ["qname_cover_condition2"]
        client_address_conditions = []
      }
    ]
    addresses = [
      {
        destination_addresses = ["destination_address5", "destination_address6"]
        source_endpoint_name = "source_endpoint_name3"
        qname_cover_conditions = []
        client_address_conditions = ["client_address_condition1"]
      },
      {
        destination_addresses = ["destination_address7", "destination_address8"]
        source_endpoint_name = "source_endpoint_name4"
        qname_cover_conditions = []
        client_address_conditions = ["client_address_condition2"]
      }
    ]
  }
}
```

Replace the values with your specific OCI tenancy OCID, VCN compartment name, VCN display name, resolver endpoint configurations, attached views, and tag definitions.

## Variables
Before using this module, you must configure the required variables. These can be set in a terraform.tfvars file for easy module configuration.

### Required Variables
- `tenancy_ocid`: The OCID of the root compartment.
- `vcn_compartment_name`: The compartment's name of the VCN associated to the DNS Resolver.
- `vcn_display_name`: The display name of the VCN associated to the DNS Resolver.

### Optional Variables
- `freeform_tags`: Simple key-value pairs to tag the resources created using freeform tags.
- `defined_tags`: Predefined and scoped to a namespace to tag the resources created using defined tags.
- `rules`: The collection of rules used for the DNS resolver. This should be formatted as a map containing two sub-maps:
    - `domain`: A sub-map representing rules based on domain names. Each key represents a unique identifier for the rule, and the corresponding value is a map containing the following attributes:
        - `destination_addresses`: (Required) A list of destination IP addresses for the rule.
        - `source_endpoint_name`: (Required) The name of the source endpoint associated with the rule.
        - `qname_cover_conditions`: (Required) A list of domains to match for the rule.
        - `client_address_conditions`: (Required) Needs to be an empty array: [].
    - `addresses`: A sub-map representing rules based on IP addresses. Each key represents a unique identifier for the rule, and the corresponding value is a map containing the following attributes:
        - `destination_addresses`: (Required) A list of destination IP addresses for the rule.
        - `source_endpoint_name`: (Required) The name of the source endpoint associated with the rule.
        - `client_address_conditions`: (Required) A list of IP addresses (segments) to match for the rule.
        - `qname_cover_conditions`: (Required) Needs to be an empty array: [].

- `attached_views`: The list of dns views to associate to the DNS resolver. Each element of the list should be a map with the following attributes:
    - `view_name`: (Required) The name of the view to associate.
    - `compartment_name`: (Required) The name of the compartment where the view to associate resides in.

- `resolver_endpoint_list`: The collection of resolver endpoint lists to include in the DNS resolver. This should be formatted as a map where each key represents the name of the resolver endpoint and the corresponding value is a map containing the following attributes:
    - `is_forwarding`: (Required) Indicates whether the resolver endpoint is for forwarding DNS queries.
    - `is_listening`: (Required) Indicates whether the resolver endpoint is listening for DNS queries.
    - `endpoint_subnet_compartment`: (Required) The name of the compartment where the subnet in which the endpoint will be placed resides.
    - `endpoint_subnet_name`: (Required) The name of the subnet in which the endpoint will be placed.
    - `resolver_endpoint_forwarding_address`: (Required) The IP address used to forward DNS queries from (only use if `is_forwarding` is true. Otherwise use a value of empty string: "").
    - `resolver_endpoint_listening_address`: (Required) The IP address that the resolver endpoint listens on (only use if `is_listening` is true. Otherwise use a value of empty string: "").
    - `nsg_name`: (Required) The name of the NSG to associate with the resolver endpoint. If no NSG is going to be used, use a value of empty string: "".

## Outputs
- `id`: The OCID of the DNS Resolver.

You can define additional outputs as needed based on the resources created within the module.

## Notes
- Ensure that you have the necessary IAM permissions to create resources in the specified compartments and VCN.
- Review and customize the module inputs according to your specific requirements.
- For more information on OCI DNS Resolver and its configuration options, refer to the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/DNS/Concepts/dnsresolver.htm).