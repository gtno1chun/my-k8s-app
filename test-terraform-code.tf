# variable "security_group_id" {}

# data "aws_security_group" "selected" {
#   id = var.security_group_id
# }
# output "security_group_id" {
#   description = "sgr-id"
#   value = data.aws_security_group.selected.id
  
# }

# data "aws_security_groups" "test" {
#   tags = {
#     Name = "eks-cluster-sg-jackchun-eks-oazw-1444394879"
#   }
# }

# data "aws_security_groups" "test" {
#   filter {
#     name = "group-name"
#     values = ["*Ubuntu*"]
#   }
# }


# output "security_group_id" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.id
  
# }
# output "security_group_arns" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.arns
  
# }
# output "security_group_ids" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.ids
  
# }
# output "security_group_vpc_ids" {
#   description = "sgr-id"
#   value = data.aws_security_groups.test.vpc_ids
  
# }


# "TG" = ["namespaces"]
variable "roles" {
  default = {
    stg = [
      {"name" = "dpl"       , "namespaces" = ["dpl"]},
      {"name" = "file"      , "namespaces" = ["file", "file-batch", "mex", "filemeta", "filemeta-batch", "cdjava"]},
      {"name" = "media"     , "namespaces" = ["samsungnotes-batch"]},
      {"name" = "odigw"     , "namespaces" = ["odi-batch"]},
      {"name" = "backup"    , "namespaces" = ["coedit-batch"]}
    ]

  }
}

variable "roles_old" {
  default = {

    stg = {
      "file" = ["file", "file-batch", "mex", "filemeta", "filemeta-batch", "cdjava"]
      "dpl"  = ["dpl"]
      "media" = ["samsungnotes-batch"]
      "odigw" = ["odi-batch"]
    }
  }
}

locals {

  env          = "stg"
}

output "test-01" {
  description = ""
  value = var.roles[local.env]
  

}
output "test-02" {
  description = "value"
  value = $element(values(var.roles_old),count.index)} 
  #${element(values(var.apples_account_vpc_ids),count.index)}
}

locals {
  roles_flat = flatten([
    for role in var.roles[local.env] : [
      for namespace in role.namespaces : {
        name      = role.name,
        namespace = namespace,
      }
    ]
  ])
}