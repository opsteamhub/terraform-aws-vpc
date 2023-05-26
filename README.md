# Terraform AWS VPC Configuration

This Terraform module provides a flexible way to create and manage AWS VPC configurations. It supports various VPC components such as DHCP options, Internet Gateways, NAT Gateways, VPC Peering Connections, Subnets, and VPC Endpoints.

## Usage

### Variables

To use this module, you must define a root module specifying definitions by variable.

#### Variable description

##### Main variable (vpc_config)

| Variable Name | Description                                                                                                                                                                                                                                                                                      |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| vpc_config    | This is a complex variable that contains multiple sub-objects, each of which corresponds to a different aspect of AWS VPC configuration. These include DHCP options, global configurations, IGWs, IPAM, NAT Gateways, NAT Instances, Peering Connections, Subnet Layers, VPC, and VPC Endpoints. |

#### Subitems

Each of the subitems within the `vpc_config` variable pertains to a different element of AWS VPC configuration. These subitems are:

| Subitem            | Description                                                |
| ------------------ | ---------------------------------------------------------- |
| dhcp_options       | Specifies the DHCP options for the VPC.                    |
| global             | Sets global configurations for the VPC.                    |
| igw                | Configures Internet Gateway for the VPC.                   |
| ipam               | Handles IP Address Management (IPAM) for the VPC.          |
| nat_gateway        | Sets NAT Gateway configurations for the VPC.               |
| nat_instance       | Configures NAT Instances for the VPC.                      |
| security_groups    | Manages the configuration of security groups for the VPC.  |
| peering_connection | Manages VPC Peering Connection configurations for the VPC. |
| subnet_layers      | Sets up Subnet layer configurations for the VPC.           |
| vpc                | Contains main VPC configurations.                          |
| vpc_endpoints      | Configures VPC Endpoints for the VPC.                      |

#### Configuration Structure

For examples on how to define and structure the aforementioned variables and subitems, please refer to the `variables.tf` file in the root of the repository.

## Examples

Examples of how to use this module are available in the `test` directory within the repository. Here, you'll find a variety of scenarios that demonstrate the capabilities of this module. These examples are meant to provide practical guidance and should be adapted to your specific needs.

Remember to replace all placeholder values in the examples with your actual AWS configuration details. In all example files, replace `your_value` with the appropriate data.

### Getting Started

To begin, go to the `test` directory and find an example that suits your needs. Make a copy of it in your workspace and start customizing.

### Security Best Practices

When dealing with sensitive information in Terraform, it's paramount to prioritize security. Follow the tips below to ensure the protection of your sensitive data:

1. **Avoid Exposing Sensitive Data**: Don't include sensitive information such as passwords, API keys, or other secrets directly in your Terraform files.
2. **Use Environment Variables**: If you're running Terraform in a CI/CD pipeline, consider using environment variables for managing sensitive data. These variables are not stored with the code, providing an added layer of security. The environment variables used by Terraform are of the form TF_VAR_name.
3. **Use AWS Role**s: If you need to provide AWS credentials access, consider using roles as a safer alternative to hardcoded keys. The AWS Security Token Service (STS) can provide temporary security credentials which Terraform can use to make authorized API requests.
4. **Leverage .gitignore**: If you must use a file to store sensitive data, ensure that this file is listed in your .gitignore or equivalent to prevent it from being committed to your version control system.
5. **Mark Variables as Sensitive**: From Terraform v0.14 and onwards, you can label variables as sensitive. When a variable is marked as such, Terraform will hide its value in the CLI output, adding an extra layer of security.

## References

HashiCorp (2023) Resource: aws_vpc. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc. (Accessed: 2023-04-14).

HashiCorp (2023) Resource: aws_subnet. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet. (Accessed: 2023-04-14).

HashiCorp (2023) Resource: aws_internet_gateway. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway. (Accessed: 2023-04-14).

HashiCorp (2023) Resource: aws_nat_gateway. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway. (Accessed: 2023-04-14).

HashiCorp (2023) Resource: aws_vpc_peering_connection. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection. (Accessed: 2023-04-14).

HashiCorp (2023) Resource: aws_vpc_endpoint. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint. (Accessed: 2023-04-14).
