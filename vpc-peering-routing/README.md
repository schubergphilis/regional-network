## Requirements

No requirements.

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| peer_routing | ../modules/vpc-peering-routing |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| peering\_vpcs | A map of VPCs pairs to peer. | <pre>map(map(object({<br>    id                      = string,<br>    name                    = string,<br>    environment             = string,<br>    availability_zones      = list(string),<br>    cidr_block              = string,<br>    peer_with_all           = bool,<br>    mesh                    = bool,<br>    cidr_block              = string,<br>    public_route_table_id   = string,<br>    private_route_table_ids = list(string)<br>  tags = map(string) })))</pre> | n/a | yes |

## Outputs

No output.
