resource "mongodbatlas_encryption_at_rest" "test" {
  project_id = var.project_id

  aws_kms_config {
    enabled                = true
    customer_master_key_id = var.cmk_id
    region                 = var.aws_region
    role_id                = "${mongodbatlas_cloud_provider_access_setup.setup_only.role_id}"
  }
  depends_on = [
    mongodbatlas_cloud_provider_access_authorization.auth_role
  ]
}

resource "mongodbatlas_database_user" "adminuser" {
  username           = var.databaseusername
  password           = var.databasepassword
  project_id         = var.project_id
  auth_database_name = "admin"
  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
}

resource "mongodbatlas_project_ip_access_list" "home" {
  project_id = var.project_id
  cidr_block = "0.0.0.0/0"
  comment    = "allow_all_ipAddresses"
}


