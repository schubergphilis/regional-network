## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| egress_to_tgw_attachment | ../modules/tgw-vpc-attachment |  |
| egress_vpc | github.com/schubergphilis/terraform-aws-mcaf-vpc.git?ref=v1.6.0 |  |
| transit_gateway | ../modules/transit-gateway |  |

## Resources

| Name |
|------|
| [aws_ec2_transit_gateway_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_flow\_log\_group\_name | The name of the cloudwatch log group. | `string` | n/a | yes |
| deployed\_vpcs | A list of VPC that are deployed. | <pre>list(object({<br>    id                 = string,<br>    name               = string,<br>    environment        = string,<br>    availability_zones = list(string),<br>    cidr_block         = string,<br>    peer_with_all      = bool,<br>    mesh               = bool,<br>    cidr_block         = string,<br>    private_subnet_ids = list(string)<br>    private_route_table_ids = list(string)<br>  tags = map(string) }))</pre> | n/a | yes |
| egress\_vpc | The name of the cloudwatch log group. | <pre>object({<br>    cidr_block          = string<br>    name                = string<br>    environment         = string<br>    availability_zones  = list(string)<br>    public_subnet_bits  = number<br>    private_subnet_bits = number<br>    tags                = map(string)<br>  })</pre> | n/a | yes |
| external\_route\_table\_name | The name of the external route table. | `string` | `"route-table-external"` | no |
| flow\_log\_retention\_period\_in\_days | The retention period for a flow log in days, defaults to 1 day. | `number` | `1` | no |
| non\_production\_route\_table\_name | The name of the non production route table. | `string` | `"route-table-non-production"` | no |
| prepend\_resource\_type | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| region | The region that the VPCs will be deployed in. | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources | `map(string)` | `{}` | no |
| transit\_gateway\_name | The name of the transit gateway to deploy. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| egress\_private\_route\_table\_ids | The private route table IDs of the Egress VPC. |
| egress\_public\_route\_table\_id | The public route table ID of the Egress VPC. |
| egress\_vpc\_attachment\_id | The attachment ID of the Egress VPC. |
| egress\_vpc\_attachment\_route\_table\_id | The attachment route table ID of the Egress VPC. |
| egress\_vpc\_cidr\_block | The cidr block of the Egress VPC. |
| external\_route\_table\_id | The ID of the external route table. |
| non\_production\_route\_table\_id | The ID of the non production route table. |
| transit\_gateway\_id | EC2 Transit Gateway identifier |
| vpc\_layout\_attachment\_ids | The attachment IDs of the all VPCs deployed in the layout. |
| vpc\_layout\_attachment\_route\_table\_ids | The attachment route table IDs of all the VPCs deployed in the layout. |
| vpc\_layout\_cidr\_blocks | The CIDR blocks of all the VPCs deployed in the layout. |
| vpc\_layout\_non\_production\_attachment\_ids | The attachment IDs of the non production VPCs deployed in the layout. |
| vpc\_layout\_non\_production\_attachment\_route\_table\_ids | The attachment route table IDs of the non production VPCs deployed in the layout. |
| vpc\_layout\_production\_attachment\_ids | The attachment IDs of the production VPCs deployed in the layout. |
| vpc\_layout\_production\_attachment\_route\_table\_ids | The attachment route table IDs of the production VPCs deployed in the layout. |
