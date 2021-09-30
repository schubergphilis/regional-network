## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_multi_region_routing"></a> [multi\_region\_routing](#module\_multi\_region\_routing) | ../modules/multi-region-routing | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route.blackhole_rfc1918_10](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.blackhole_rfc1918_172](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.blackhole_rfc1918_192](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.default_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.egress_vpc_to_layout_vpcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.external_domain_to_vpcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.layout_vpcs_to_egress_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.non_production_domain_to_vpcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_route.egress_private_to_vpcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.egress_public_to_vpcs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_consul_data_lookup"></a> [consul\_data\_lookup](#input\_consul\_data\_lookup) | Use consul as a data source to determine routes to deploy. | `bool` | `false` | no |
| <a name="input_egress_vpc_attachment_id"></a> [egress\_vpc\_attachment\_id](#input\_egress\_vpc\_attachment\_id) | The attachment ID of the Egress VPC. | `string` | n/a | yes |
| <a name="input_egress_vpc_attachment_route_table_id"></a> [egress\_vpc\_attachment\_route\_table\_id](#input\_egress\_vpc\_attachment\_route\_table\_id) | The transit gateway attachment route table ID of the Egress VPC. | `string` | n/a | yes |
| <a name="input_egress_vpc_cidr_block"></a> [egress\_vpc\_cidr\_block](#input\_egress\_vpc\_cidr\_block) | The cidr block of the Egress VPC. | `string` | n/a | yes |
| <a name="input_egress_vpc_private_route_table_ids"></a> [egress\_vpc\_private\_route\_table\_ids](#input\_egress\_vpc\_private\_route\_table\_ids) | The IDs of the private route tables of the Egress VPC. | `list(string)` | n/a | yes |
| <a name="input_egress_vpc_public_route_table_id"></a> [egress\_vpc\_public\_route\_table\_id](#input\_egress\_vpc\_public\_route\_table\_id) | The ID of the public route table of the Egress VPC. | `string` | n/a | yes |
| <a name="input_external_route_table_id"></a> [external\_route\_table\_id](#input\_external\_route\_table\_id) | The ID of the external route table. | `string` | n/a | yes |
| <a name="input_non_production_route_table_id"></a> [non\_production\_route\_table\_id](#input\_non\_production\_route\_table\_id) | The transit gateway non production route table ID. | `string` | n/a | yes |
| <a name="input_peer_routing_regions"></a> [peer\_routing\_regions](#input\_peer\_routing\_regions) | A list of regions to calculate regional routing for. | `list(string)` | `[]` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | The transit gateway ID. | `string` | n/a | yes |
| <a name="input_vpc_layout_acceptance_attachment_route_table_ids"></a> [vpc\_layout\_acceptance\_attachment\_route\_table\_ids](#input\_vpc\_layout\_acceptance\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the acceptance VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_attachment_ids"></a> [vpc\_layout\_attachment\_ids](#input\_vpc\_layout\_attachment\_ids) | The transit gateway attachment IDs of the VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_attachment_route_table_ids"></a> [vpc\_layout\_attachment\_route\_table\_ids](#input\_vpc\_layout\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_cidr_blocks"></a> [vpc\_layout\_cidr\_blocks](#input\_vpc\_layout\_cidr\_blocks) | The cidr blocks VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_development_attachment_route_table_ids"></a> [vpc\_layout\_development\_attachment\_route\_table\_ids](#input\_vpc\_layout\_development\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the development VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_non_production_attachment_ids"></a> [vpc\_layout\_non\_production\_attachment\_ids](#input\_vpc\_layout\_non\_production\_attachment\_ids) | The transit gateway attachment IDs of the non production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_non_production_attachment_route_table_ids"></a> [vpc\_layout\_non\_production\_attachment\_route\_table\_ids](#input\_vpc\_layout\_non\_production\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the non production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_production_attachment_ids"></a> [vpc\_layout\_production\_attachment\_ids](#input\_vpc\_layout\_production\_attachment\_ids) | The transit gateway attachment IDs of the production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_production_attachment_route_table_ids"></a> [vpc\_layout\_production\_attachment\_route\_table\_ids](#input\_vpc\_layout\_production\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_services_attachment_route_table_ids"></a> [vpc\_layout\_services\_attachment\_route\_table\_ids](#input\_vpc\_layout\_services\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the services VPCs deployed in the layout. | `list(string)` | n/a | yes |
| <a name="input_vpc_layout_test_attachment_route_table_ids"></a> [vpc\_layout\_test\_attachment\_route\_table\_ids](#input\_vpc\_layout\_test\_attachment\_route\_table\_ids) | The transit gateway attachment route table IDs of the test VPCs deployed in the layout. | `list(string)` | n/a | yes |

## Outputs

No outputs.
