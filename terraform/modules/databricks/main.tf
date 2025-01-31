

data "databricks_current_user" "me" {}

locals {
  resource_group_name = format("rg-%s-%s", var.owner_custom, var.purpose_custom)
}

data "databricks_node_type" "smallest" {
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

data "azurerm_key_vault_secret" "db-un" {
  name         = "db-username"
  key_vault_id = var.key_vault_id
}


data "azurerm_key_vault_secret" "db-pw" {
  name         = "db-password"
  key_vault_id = var.key_vault_id
}

resource "azurerm_databricks_workspace" "adb" {
  name                = format("adb-%s-%s", var.owner_custom, var.purpose_custom)
  resource_group_name = local.resource_group_name
  location            = var.location
  sku                 = "premium"

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = var.vnet_id
    public_subnet_name                                   = "public_subnet"
    private_subnet_name                                  = "private_subnet"
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
  }
}


resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = format("%s-%s-cluster", var.owner_custom, var.purpose_custom)
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 20
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  spark_conf = {

  }
}

# resource "databricks_secret_scope" "kv" {
#   name = "keyvault-managed"

#   keyvault_metadata {
#     resource_id = var.key_vault_id
#     dns_name    = var.key_vault_uri
#   }
# }