module "roles" {
  source = "github.com/global-devops-terraform/user-roles?ref=v1.5.2"

  devops_roles        = var.devops_management
  developer_roles     = var.dev_worker
  developer_role_name = "DevAccess"
}
