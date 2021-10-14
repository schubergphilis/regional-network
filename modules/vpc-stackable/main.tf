resource "aws_security_group" "vpc_endpoint" {
  name        = "${var.prepend_resource_type ? "sgp-ssm-endpoints-" : ""}${var.name}"
  description = "Allow inbound https traffic."
  vpc_id      = module.vpc.id
  tags        = merge(var.tags, { Name = "${var.prepend_resource_type ? "sgp-ssm-endpoints-" : ""}${var.name}" })
}

resource "aws_security_group_rule" "vpc_endpoint" {
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.cidr_block]
  security_group_id = aws_security_group.vpc_endpoint.id
}

module "vpc" {
  source                     = "github.com/schubergphilis/terraform-aws-mcaf-vpc.git?ref=v1.12.0"
  name                       = var.name
  cidr_block                 = var.cidr_block
  dhcp_options               = var.dhcp_options
  availability_zones         = var.availability_zones
  tags                       = merge(var.tags, { environment = var.environment })
  public_subnet_bits         = var.public_subnet_bits
  private_subnet_bits        = var.private_subnet_bits
  prepend_resource_type      = var.prepend_resource_type
  private_s3_endpoint        = true
  share_private_subnets      = true
  share_public_subnets       = true
  enable_nat_gateway         = var.enable_nat_gateway
  subnet_sharing_custom_tags = merge(var.tags, { environment = var.environment, resource-type = "ec2:Subnet" })
  flow_logs = {
    retention_in_days = var.flow_log_retention_period_in_days
    traffic_type      = "ALL"
    log_group_name    = var.cloudwatch_flow_log_group_name
    iam_role_name     = "${var.prepend_resource_type ? "vpc-flow-logs-" : ""}${var.name}-${var.region}"
  }
  ebs_endpoint = {
    subnet_ids          = module.vpc.private_subnet_ids
    private_dns_enabled = true
    security_group_ids  = [aws_security_group.vpc_endpoint.id]
  }
  ec2_endpoint = {
    subnet_ids          = module.vpc.private_subnet_ids
    private_dns_enabled = true
    security_group_ids  = [aws_security_group.vpc_endpoint.id]
  }
  ec2messages_endpoint = {
    subnet_ids          = module.vpc.private_subnet_ids
    private_dns_enabled = true
    security_group_ids  = [aws_security_group.vpc_endpoint.id]
  }
  ssm_endpoint = {
    subnet_ids          = module.vpc.private_subnet_ids
    private_dns_enabled = true
    security_group_ids  = [aws_security_group.vpc_endpoint.id]
  }
  ssmmessages_endpoint = {
    subnet_ids          = module.vpc.private_subnet_ids
    private_dns_enabled = true
    security_group_ids  = [aws_security_group.vpc_endpoint.id]
  }
}
