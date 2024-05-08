module "airbyte_stateful" {
  for_each = { for item in try(local.workspace.airbyte, []) : item.name => item }
  source              = "git::https://github.com/DNXLabs/terraform-aws-stateful-airbyte.git"
  name            = each.value.name
  instance_type   = each.value.instance_type
  instance_count  = each.value.instance_count
  efs_mount_dir   = each.value.efs_mount_dir
  hostname_create = each.value.hostname_create
  hostnames       = each.value.hostnames
  hosted_zone     = each.value.hosted_zone
  lb_type         = each.value.lb_type
  tcp_ports       = each.value.tcp_ports
  sg_cidr_blocks  = each.value.sg_cidr_blocks
  
  vpc_id          = data.aws_vpc.selected[0].id
  userdata        = file("./templates/airbyte.sh")

  instances_subnet_ids = data.aws_subnet_ids.private[0].ids
  efs_subnet_ids       = data.aws_subnet_ids.secure[0].ids
  lb_subnet_ids        = data.aws_subnet_ids.private[0].ids
}