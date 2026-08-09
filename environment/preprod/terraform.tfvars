rgs = {
  rg1 = {
    name     = "rg-b18-preprod"
    location = "West Europe"
  }
}

storage_accounts = {
  stg1 = {
    name                     = "stgb18preprod001"
    resource_group_name      = "rg-b18-preprod"
    location                 = "West Europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
