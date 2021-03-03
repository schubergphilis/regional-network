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
| [aws_route53_resolver_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) |
| [aws_route53_resolver_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns\_forwarders | A list of DNS forwarder IPs to apply. | `list(string)` | `[]` | no |
| domain\_forwarder\_tags | The tags of the domain forwarders. | `map(string)` | `{}` | no |
| forward\_domains | A list of forward domains to deploy. | <pre>list(object({<br>    name        = string<br>    rule_name   = string<br>    description = string<br>    rule_type   = string<br>  }))</pre> | `[]` | no |
| forwarder\_override\_tags | The tags of the forwarder overrides. | `map(string)` | `{}` | no |
| resolver\_name | The name for the resolver. | `string` | `""` | no |
| resolver\_tags | The tags of the resolver. | `map(string)` | `{}` | no |
| resolver\_type | The type of the resolver. | `string` | n/a | yes |
| security\_group\_resolver\_name | The name of the security group resolver. | `string` | `""` | no |
| security\_group\_rule\_cidr\_blocks | The CIDR blocks for the security group. | `list(string)` | `[]` | no |
| security\_group\_tags | The tags for the security group. | `map(string)` | `{}` | no |
| security\_group\_vpc\_id | The VPC ID for the security group. | `string` | `""` | no |
| subnet\_ids\_for\_resolver\_endpoints | The subnet IDs for the resolver endpoints. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| resolver\_rule\_ids | The IDs of the resolver rules created. |
