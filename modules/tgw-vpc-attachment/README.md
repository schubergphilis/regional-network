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
| [aws_ec2_transit_gateway_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) |
| [aws_ec2_transit_gateway_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) |
| [aws_ec2_transit_gateway_route_table_propagation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) |
| [aws_ec2_transit_gateway_vpc_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) |
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment label to use. | `string` | n/a | yes |
| name | Name to be used on all the resources as identifier | `string` | `""` | no |
| prepend\_resource\_type | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| route\_table\_ids | The IDs of the route tables. | `list(string)` | n/a | yes |
| subnet\_ids | The IDs of the subnets. | `list(string)` | n/a | yes |
| tags | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |
| transit\_gateway\_id | The ID of the transit gateway. | `string` | n/a | yes |
| vpc\_id | The IDs VPC to attach. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| attachment\_id | The ID of the attachment. |
| environment | The environment of the attachment. |
| route\_table\_id | The ID of the attachment route table. |
