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
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) |
| [aws_vpc_peering_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prepend\_resource\_type | If set it will prepend the resource type on the name of the resource. | `bool` | `true` | no |
| vpc\_pair | A map of VPC pairs to peer together. | <pre>map(object({<br>    id                      = string,<br>    name                    = string,<br>    environment             = string,<br>    availability_zones      = list(string),<br>    cidr_block              = string,<br>    peer_with_all           = bool,<br>    mesh                    = bool,<br>    cidr_block              = string,<br>    public_route_table_id   = string,<br>    private_route_table_ids = list(string)<br>  tags = map(string) }))</pre> | n/a | yes |

## Outputs

No output.
