## Requirements

No requirements.

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| inbound_resolvers | ../modules/route53-resolver |  |
| outbound_resolver | ../modules/route53-resolver |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_forwarding | The definition of the dns forwarders and the forward domains to apply. | <pre>object({<br>		dns_forwarders = list(string)<br>		forward_domains = list(object({<br>			name = string<br>			rule_name = string<br>			description = string<br>			rule_type = string<br>		}))<br>	})</pre> | <pre>{<br>  "dns_forwarders": [],<br>  "forward_domains": []<br>}</pre> | no |
| enable\_inbound\_resolvers | If set it will enable the inbound resolver. | `bool` | `false` | no |
| inbound\_resolver\_name | The name of the inbound resolver. | `string` | `""` | no |
| inbound\_resolver\_tags | The tags to attach to the inbound resolver. | `map(string)` | `{}` | no |
| inbound\_security\_group\_resolver\_name | The name of the inbound resolver security group. | `string` | n/a | yes |
| inbound\_security\_group\_tags | The tags to attach to the inbound resolver security group. | `map(string)` | `{}` | no |
| outbound\_resolver\_name | The name of the outbound resolver. | `string` | `""` | no |
| outbound\_resolver\_tags | The tags to attach to the outbound resolver. | `map(string)` | `{}` | no |
| outbound\_security\_group\_resolver\_name | The name of the outbound resolver security group. | `string` | n/a | yes |
| outbound\_security\_group\_tags | The tags to attach to the outbound resolver security group. | `map(string)` | `{}` | no |
| security\_group\_rule\_cidr\_blocks | The cidr blocks for the security group rule. | `list(string)` | `[]` | no |
| security\_group\_vpc\_id | The ID of the VPC for the security group. | `string` | n/a | yes |
| subnet\_ids\_for\_resolver\_endpoints | A list of subnet IDs to assign to the resolver endpoints. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| resolver\_rule\_ids | The IDs of the resolver rules. |
