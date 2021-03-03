## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_ec2_transit_gateway_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) |
| [aws_ec2_transit_gateway_route_table_propagation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) |
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| egress\_vpc\_attachment\_id | The attachment ID of the Egress VPC. | `string` | n/a | yes |
| egress\_vpc\_attachment\_route\_table\_id | The transit gateway attachment route table ID of the Egress VPC. | `string` | n/a | yes |
| egress\_vpc\_cidr\_block | The cidr block of the Egress VPC. | `string` | n/a | yes |
| egress\_vpc\_private\_route\_table\_ids | The IDs of the private route tables of the Egress VPC. | `list(string)` | n/a | yes |
| egress\_vpc\_public\_route\_table\_id | The ID of the public route table of the Egress VPC. | `string` | n/a | yes |
| external\_route\_table\_id | The ID of the external route table. | `string` | n/a | yes |
| non\_production\_route\_table\_id | The transit gateway non production route table ID. | `string` | n/a | yes |
| transit\_gateway\_id | The transit gateway ID. | `string` | n/a | yes |
| vpc\_layout\_attachment\_ids | The transit gateway attachment IDs of the VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_attachment\_route\_table\_ids | The transit gateway attachment route table IDs of the VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_cidr\_blocks | The cidr blocks VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_non\_production\_attachment\_ids | The transit gateway attachment IDs of the non production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_non\_production\_attachment\_route\_table\_ids | The transit gateway attachment route table IDs of the non production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_production\_attachment\_ids | The transit gateway attachment IDs of the production VPCs deployed in the layout. | `list(string)` | n/a | yes |
| vpc\_layout\_production\_attachment\_route\_table\_ids | The transit gateway attachment route table IDs of the production VPCs deployed in the layout. | `list(string)` | n/a | yes |

## Outputs

No output.
