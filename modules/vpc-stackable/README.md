## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | github.com/schubergphilis/terraform-aws-mcaf-vpc.git?ref=v1.6.0 |  |

## Resources

| Name |
|------|
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zones | A list of availability zones for the subnets. | `list(string)` | n/a | yes |
| cidr\_block | The CIDR block for the VPC. | `string` | n/a | yes |
| cloudwatch\_flow\_log\_group\_name | The name of the cloudwatch log group. | `string` | n/a | yes |
| dhcp\_options | The dhcp options to apply to the VPC. | <pre>object({<br>    domain_name          = string<br>    domain_name_servers  = list(string)<br>    ntp_servers          = list(string)<br>    netbios_name_servers = list(string)<br>    netbios_node_type    = number<br>  })</pre> | `null` | no |
| enable\_nat\_gateway | If set it will enable the nat gateways of the VPC. | `bool` | `false` | no |
| environment | The environment of the VPC. | `string` | n/a | yes |
| flow\_log\_retention\_period\_in\_days | The retention period for a flow log in days, defaults to 1 day. | `number` | `1` | no |
| mesh | A flag to peer the VPC with all other mesh VPCs. | `bool` | `false` | no |
| name | Used as part of the resource names to indicate they are created and used within a specific name. | `string` | n/a | yes |
| peer\_with\_all | A flag to peer the VPC with all other VPCs. | `bool` | `false` | no |
| prepend\_resource\_type | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| private\_subnet\_bits | The number of bits used for the subnet mask. | `number` | `null` | no |
| public\_subnet\_bits | The number of bits used for the subnet mask. | `number` | `null` | no |
| region | The region that the VPCs will be deployed in. | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| availability\_zones | The availability zones provided. |
| cidr\_block | CIDR block of the VPC. |
| environment | The environment set for the VPC. |
| id | ID of the VPC. |
| igw\_id | ID of the Internet Gateway. |
| lambda\_route\_table\_ids | IDs of the Lambda route tables. |
| lambda\_subnet\_arns | ARNs of the Lambda subnets. |
| lambda\_subnet\_cidr\_blocks | CIDR blocks of the Lambda subnets. |
| lambda\_subnet\_ids | IDs of the Lambda subnets. |
| mesh | If set the VPC will be peered with all other VPCs set as part of a full mesh network. |
| name | The name provided for the VPC. |
| nat\_gateway\_ids | IDs of the NAT gateways. |
| peer\_with\_all | If set the VPC will be peered with all other existing VPCs. |
| private\_route\_table\_ids | IDs of the private route tables. |
| private\_subnet\_arns | ARNs of the private subnets. |
| private\_subnet\_cidr\_blocks | CIDR blocks of the private subnets. |
| private\_subnet\_ids | IDs of the private subnets. |
| public\_route\_table\_id | ID of the public route table. |
| public\_subnet\_arns | ARNs of the public subnets. |
| public\_subnet\_cidr\_blocks | CIDR blocks of the public subnets. |
| public\_subnet\_ids | IDs of the public subnets. |
| subnet\_share\_arn | The ARN of the subnet share in resource access manager if any. |
| subnet\_share\_id | The ID of the subnet share in resource access manager if any. |
| tags | The tags provided. |
| vpc | The deployed VPC. |
