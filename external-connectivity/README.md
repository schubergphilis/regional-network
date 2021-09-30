## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_consul_data_exports"></a> [consul\_data\_exports](#module\_consul\_data\_exports) | ../modules/consul-data-exports | n/a |
| <a name="module_egress_to_tgw_attachment"></a> [egress\_to\_tgw\_attachment](#module\_egress\_to\_tgw\_attachment) | ../modules/tgw-vpc-attachment | n/a |
| <a name="module_egress_vpc"></a> [egress\_vpc](#module\_egress\_vpc) | github.com/schubergphilis/terraform-aws-mcaf-vpc.git | v1.6.0 |
| <a name="module_transit_gateway"></a> [transit\_gateway](#module\_transit\_gateway) | ../modules/transit-gateway | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_route_table.external_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.non_production_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.external_route_domain_to_foreign_global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_peering_attachment.foreign_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_peering_attachment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_flow_log_group_name"></a> [cloudwatch\_flow\_log\_group\_name](#input\_cloudwatch\_flow\_log\_group\_name) | The name of the cloudwatch log group. | `string` | n/a | yes |
| <a name="input_consul_export_base_path"></a> [consul\_export\_base\_path](#input\_consul\_export\_base\_path) | The base path within consul KV store to export data to. | `string` | `null` | no |
| <a name="input_deployed_vpcs"></a> [deployed\_vpcs](#input\_deployed\_vpcs) | A list of VPC that are deployed. | <pre>list(object({<br>    id                      = string,<br>    name                    = string,<br>    environment             = string,<br>    availability_zones      = list(string),<br>    cidr_block              = string,<br>    peer_with_all           = bool,<br>    mesh                    = bool,<br>    cidr_block              = string,<br>    private_subnet_ids      = list(string)<br>    private_route_table_ids = list(string)<br>  tags = map(string) }))</pre> | n/a | yes |
| <a name="input_egress_vpc"></a> [egress\_vpc](#input\_egress\_vpc) | The name of the cloudwatch log group. | <pre>object({<br>    cidr_block          = string<br>    name                = string<br>    environment         = string<br>    availability_zones  = list(string)<br>    public_subnet_bits  = number<br>    private_subnet_bits = number<br>    tags                = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_export_data_to_consul"></a> [export\_data\_to\_consul](#input\_export\_data\_to\_consul) | If set will export all data to consul at specified base path. | `bool` | `false` | no |
| <a name="input_external_route_table_name"></a> [external\_route\_table\_name](#input\_external\_route\_table\_name) | The name of the external route table. | `string` | `"route-table-external"` | no |
| <a name="input_flow_log_retention_period_in_days"></a> [flow\_log\_retention\_period\_in\_days](#input\_flow\_log\_retention\_period\_in\_days) | The retention period for a flow log in days, defaults to 1 day. | `number` | `1` | no |
| <a name="input_non_production_route_table_name"></a> [non\_production\_route\_table\_name](#input\_non\_production\_route\_table\_name) | The name of the non production route table. | `string` | `"route-table-non-production"` | no |
| <a name="input_peer_regions"></a> [peer\_regions](#input\_peer\_regions) | n/a | `list(string)` | `[]` | no |
| <a name="input_prepend_resource_type"></a> [prepend\_resource\_type](#input\_prepend\_resource\_type) | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | The region that the VPCs will be deployed in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_amazon_side_asn"></a> [transit\_gateway\_amazon\_side\_asn](#input\_transit\_gateway\_amazon\_side\_asn) | The Amazon side asn number to assign to the transit gateway. | `string` | `"64512"` | no |
| <a name="input_transit_gateway_name"></a> [transit\_gateway\_name](#input\_transit\_gateway\_name) | The name of the transit gateway to deploy. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_egress_private_route_table_ids"></a> [egress\_private\_route\_table\_ids](#output\_egress\_private\_route\_table\_ids) | The private route table IDs of the Egress VPC. |
| <a name="output_egress_public_route_table_id"></a> [egress\_public\_route\_table\_id](#output\_egress\_public\_route\_table\_id) | The public route table ID of the Egress VPC. |
| <a name="output_egress_vpc_attachment_id"></a> [egress\_vpc\_attachment\_id](#output\_egress\_vpc\_attachment\_id) | The attachment ID of the Egress VPC. |
| <a name="output_egress_vpc_attachment_route_table_id"></a> [egress\_vpc\_attachment\_route\_table\_id](#output\_egress\_vpc\_attachment\_route\_table\_id) | The attachment route table ID of the Egress VPC. |
| <a name="output_egress_vpc_cidr_block"></a> [egress\_vpc\_cidr\_block](#output\_egress\_vpc\_cidr\_block) | The cidr block of the Egress VPC. |
| <a name="output_external_route_table_id"></a> [external\_route\_table\_id](#output\_external\_route\_table\_id) | The ID of the external route table. |
| <a name="output_non_production_route_table_id"></a> [non\_production\_route\_table\_id](#output\_non\_production\_route\_table\_id) | The ID of the non production route table. |
| <a name="output_transit_gateway_id"></a> [transit\_gateway\_id](#output\_transit\_gateway\_id) | EC2 Transit Gateway identifier |
| <a name="output_vpc_layout_attachment_ids"></a> [vpc\_layout\_attachment\_ids](#output\_vpc\_layout\_attachment\_ids) | The attachment IDs of the all VPCs deployed in the layout. |
| <a name="output_vpc_layout_attachment_route_table_ids"></a> [vpc\_layout\_attachment\_route\_table\_ids](#output\_vpc\_layout\_attachment\_route\_table\_ids) | The attachment route table IDs of all the VPCs deployed in the layout. |
| <a name="output_vpc_layout_cidr_blocks"></a> [vpc\_layout\_cidr\_blocks](#output\_vpc\_layout\_cidr\_blocks) | The CIDR blocks of all the VPCs deployed in the layout. |
| <a name="output_vpc_layout_non_production_attachment_ids"></a> [vpc\_layout\_non\_production\_attachment\_ids](#output\_vpc\_layout\_non\_production\_attachment\_ids) | The attachment IDs of the non production VPCs deployed in the layout. |
| <a name="output_vpc_layout_non_production_attachment_route_table_ids"></a> [vpc\_layout\_non\_production\_attachment\_route\_table\_ids](#output\_vpc\_layout\_non\_production\_attachment\_route\_table\_ids) | The attachment route table IDs of the non production VPCs deployed in the layout. |
| <a name="output_vpc_layout_production_attachment_ids"></a> [vpc\_layout\_production\_attachment\_ids](#output\_vpc\_layout\_production\_attachment\_ids) | The attachment IDs of the production VPCs deployed in the layout. |
| <a name="output_vpc_layout_production_attachment_route_table_ids"></a> [vpc\_layout\_production\_attachment\_route\_table\_ids](#output\_vpc\_layout\_production\_attachment\_route\_table\_ids) | The attachment route table IDs of the production VPCs deployed in the layout. |
