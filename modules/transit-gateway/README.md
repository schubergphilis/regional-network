## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| attachment_route_table | ../tgw-vpc-attachment |  |

## Resources

| Name |
|------|
| [aws_ec2_transit_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) |
| [aws_ram_principal_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) |
| [aws_ram_resource_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) |
| [aws_ram_resource_share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| description | Description of the EC2 Transit Gateway. | `string` | `null` | no |
| enable\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted. | `bool` | `false` | no |
| enable\_default\_route\_table\_association | Whether resource attachments are automatically associated with the default association route table. | `bool` | `true` | no |
| enable\_default\_route\_table\_propagation | Whether resource attachments automatically propagate routes to the default propagation route table. | `bool` | `true` | no |
| enable\_dns\_support | Should be true to enable DNS support in the TGW. | `bool` | `true` | no |
| enable\_sharing | Whether to share your transit gateway with other accounts. | `bool` | `true` | no |
| enable\_vpn\_ecmp\_support | Whether VPN Equal Cost Multipath Protocol support is enabled. | `bool` | `true` | no |
| name | Name to be used on all the resources as identifier. | `string` | `""` | no |
| ram\_allow\_external\_principals | Indicates whether principals outside your organization can be associated with a resource share. | `bool` | `false` | no |
| ram\_principals | A list of principals to share TGW with. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN | `list(string)` | `[]` | no |
| ram\_share\_name | The name of the resource share of TGW. | `string` | `""` | no |
| ram\_tags | Additional tags for the RAM. | `map(string)` | `{}` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| transit\_gateway\_route\_table\_id | Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs. | `string` | `null` | no |
| transit\_gateway\_route\_table\_tags | Additional tags for the TGW route table. | `map(string)` | `{}` | no |
| transit\_gateway\_tags | Additional tags for the TGW. | `map(string)` | `{}` | no |
| transit\_gateway\_vpc\_attachment\_tags | Additional tags for VPC attachments. | `map(string)` | `{}` | no |
| vpcs\_to\_attach | A list of VPCs to attach to the gateway. | <pre>list(object({<br>    id                 = string,<br>    name               = string,<br>    environment        = string,<br>    availability_zones = list(string),<br>    peer_with_all      = bool,<br>    mesh               = bool,<br>    cidr_block         = string,<br>    private_subnet_ids = list(string)<br>    private_route_table_ids = list(string)<br>  tags = map(string) }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | EC2 Transit Gateway identifier. |
| vpc\_layout\_attachment\_ids | The attachment IDs of the all VPCs attached to the transit gateway. |
| vpc\_layout\_attachments\_route\_table\_ids | The attachment route table IDs of the all VPCs attached to the transit gateway. |
| vpc\_layout\_cidr\_blocks | The cidr blocks of all the attached VPCs. |
| vpc\_layout\_non\_production\_attachment\_ids | The attachment IDs of the non production VPCs attached to the transit gateway. |
| vpc\_layout\_non\_production\_attachment\_route\_table\_ids | The attachment route table IDs of the non production VPCs attached to the transit gateway. |
| vpc\_layout\_production\_attachment\_ids | The attachment IDs of the production VPCs attached to the transit gateway. |
| vpc\_layout\_production\_attachment\_route\_table\_ids | The attachment route table IDs of the production VPCs attached to the transit gateway. |
