## Requirements

No requirements.

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| layout | ../modules/vpc-stackable |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_nat\_gateways | A flag to enable the nat gateways of the VPCs. | `bool` | `false` | no |
| flow\_log\_retention\_period\_in\_days | The retention period for a flow log in days, defaults to 1 day. | `number` | `1` | no |
| prepend\_resource\_type | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| region | The region that the VPCs will be deployed in. | `string` | n/a | yes |
| vpcs | A list of VPC definitions to be deployed. | <pre>list(object({<br>    name                = string<br>    environment         = string<br>    availability_zones  = list(string)<br>    cidr_block          = string<br>    public_subnet_bits  = number<br>    private_subnet_bits = number<br>    peer_with_all       = bool<br>    mesh                = bool<br>    tags                = map(string)<br>    dhcp_options = object({<br>      domain_name          = string<br>      domain_name_servers  = list(string)<br>      ntp_servers          = list(string)<br>      netbios_name_servers = list(string)<br>      netbios_node_type    = number<br>    })<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| configuration | The VPCs provided as configuration |
| configured\_environments | All the distinct environments configured for the existing VPCs |
| services\_vpc | All the VPCs created by the vpcs definition that acting as a service VPC with connectivity to all |
| vpc\_pairs\_mesh | n/a |
| vpc\_pairs\_same\_environment | n/a |
| vpc\_pairs\_services\_to\_all | n/a |
| vpcs\_all | All the VPCs created by the network definition |
| vpcs\_mesh | All the VPCs created by the vpcs definition that are meshed peered |
| vpcs\_non\_mesh | All the VPCs created by the vpcs definition that are properly segregated |
| vpcs\_non\_services | All the VPCs created by the vpcs definition that not marked as shared services VPCs |
| vpcs\_services | All the VPCs created by the vpcs definition that acting as a service VPC with connectivity to all |
