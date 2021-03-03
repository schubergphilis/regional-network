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
| [aws_route53_resolver_rule_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resolver\_rule\_ids | The IDs of the resolving rules to associate with the VPCs. | `list(string)` | `[]` | no |
| vpc\_ids\_to\_associate | The IDs of the VPCs to associate with the resolving rules. | `list(string)` | `[]` | no |

## Outputs

No output.
