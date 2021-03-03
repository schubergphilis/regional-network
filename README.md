# Environmental VPC with shared subnets Design Pattern.
This module implements a regional network with multiple VPCs per environment and shared subnets. It is based on terraform modules that are orchestrated as layers of functionality by terragrunt.
The independent modules do not really make much sense in isolation as they are designed to deliver a full working networking following a specific network design that deals with specific requirements.
Thus this module is a very opinionated implementation of the following design. 

![Network Design](./network_design.svg)

## Principles

### VPCs per environment

The pattern utilizes a VPC per invironment for development, test, acceptance and production. 
Each VPC will have public and private subnets as is described by AWS networking best practices.
Those subnets will be shared through Resource Access Manager and all workloads deployd in a landing
zone with this networking will get access to the subnets per their respective environment and deploy 
resources based on the subnet sharing design. [Shared Subnets Documentation.](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-sharing.html)

### Mesh VPCs

The concept of a mesh VPC is an environmental VPC that is peered to other VPCs not of the same environment.
Example: Client states that it is important that a development system has network connectivity to a production system.
         
This networking pattern is generally not advised but is often a hard business requirement often seen as a hard requirement for SAP systems, 
therefore this optional set of VPCs can be deployed so systems requiring this capability can be somewhat isolated from other standard systems.

### Service VPC
    
This VPC type implements a common 'shared services' pattern. Its features include peering to all other VPCs in the 
landscape and will also house features like dns resolvers that provide services region wide to the full network. 

The workloads that will be flagged as services will have their production account use the Services VPC for their resources.

Effectively what that means is that from the workload's perspective they always have up to four environments: Development, 
Test, Acceptance and Production with the production being isolated in case of "normal" workloads and connected to everything
in case of a "service" workload. A good example for a "service" workload would be ansible [AWX](https://github.com/ansible/awx) / 
[Tower](https://www.ansible.com/products/tower) that would need to be able to execute ansible scripts across all possible environments 
or a hosted AD that would provide domain joins across environments.


### Transit gateway
    
An AWS transit gateway that provides all regional interconnectivity/on-prem connectivity and handles all transport
of egress traffic towards the egress VPC. All inter-region connectivity is handled by the VPCs and their peering according 
to their environment, with all same environment VPCs (isolated and meshed) peered and routed between them, all mesh VPCs peered
and routed between them and the services VPC being peered and routed to all the other ones. If traffic is not bound to any of those
endpoints it will be forwarded to the transit gateway that will handle it accordingly.
    

### Egress VPC
    
A VPC designed for the express purpose of handling and centralizing all egress traffic from the private subnets 
in the network landscape. 


### Dns Resolvers

Optional Route53 resolvers that function in the [OUTBOUND](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-forwarding-outbound-queries.html)
direction to provide DNS forwarding capability for VPCs to non native resolvers (useful in hybrid deployments). 
Optional Route53 resolvers that function in the [INBOUND](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver.html) 
direction to provide dns resolving capabilities for foreign systems. (useful in hybrid deployments, 
working as an upstream forwarder for an Active directory deployment, for example)

## Relation to the code

From the points above the VPCs per environment, the MESH VPCs, and the Service VPC are handled by the vpc-layout module 