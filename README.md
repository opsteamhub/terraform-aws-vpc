# Terraform AWS VPC Configuration

This Terraform module provides a flexible way to create and manage AWS VPC configurations. It supports various VPC components such as DHCP options, Internet Gateways, NAT Gateways, VPC Peering Connections, Subnets, and VPC Endpoints.

## Usage

### Variables

To use this module, you must define a root module specifying definitions by variable.

#### Variable description

##### Main variable (vpc_config)

| Variable Name | Description                                                                                                                                                                                 |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| vpc_config    | AWS VPC configurations (contains various sub-objects for DHCP options, global configs, IGWs, IPAM, NAT Gateways, NAT Instances, Peering Connections, Subnet Layers, VPC, and VPC Endpoints) |

##### Subitems

| Sublevel Name      | Description                                            |
| ------------------ | ------------------------------------------------------ |
| dhcp_options       | DHCP options for the VPC                               |
| global             | Global configurations for the VPC                      |
| igw                | Internet Gateway configurations for the VPC            |
| ipam               | IP Address Management (IPAM) configuration for the VPC |
| nat_gateway        | NAT Gateway configurations for the VPC                 |
| nat_instance       | NAT Instance configurations for the VPC                |
| peering_connection | VPC Peering Connection configurations for the VPC      |
| subnet_layers      | Subnet layer configurations for the VPC                |
| vpc                | Main VPC configurations                                |
| vpc_endpoints      | VPC Endpoints configurations for the VPC               |

#### Variable structure

For examples on how to configure the variables described above, please refer to the respective variable blocks in the `variables.tf` file.

## References

HashiCorp (2021) Resource: aws_vpc. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc. (Accessed: 2023-04-14).

HashiCorp (2021) Resource: aws_subnet. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet. (Accessed: 2023-04-14).

HashiCorp (2021) Resource: aws_internet_gateway. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway. (Accessed: 2023-04-14).

HashiCorp (2021) Resource: aws_nat_gateway. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway. (Accessed: 2023-04-14).

HashiCorp (2021) Resource: aws_vpc_peering_connection. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection. (Accessed: 2023-04-14).

HashiCorp (2021) Resource: aws_vpc_endpoint. Retrieved from: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint. (Accessed: 2023-04-14).
