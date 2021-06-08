module "roles" {
  source = "github.com/global-devops-terraform/user-roles?ref=v1.10.1"

  devops_roles        = var.devops_management
  developer_roles     = var.dev_worker
  developer_role_name = "DevAccess"
}
