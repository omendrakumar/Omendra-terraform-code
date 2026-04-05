terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.67.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# Resource Group List
variable "resource_groups" {
  default = ["rg-dev", "rg-test", "rg-prod"]
}

# Resource Group Creation
resource "azurerm_resource_group" "rg" {
  for_each = toset(var.resource_groups)

  name     = each.value
  location = "Central India"

  tags = {
    environment = each.value
    owner       = "omendra"
  }
}

# Random name for storage account
resource "random_string" "name" {
  length  = 6
  special = false
  upper   = false
}

# Storage Account (only for dev)
resource "azurerm_storage_account" "sa" {
  name                     = "st${random_string.name.result}"
  resource_group_name      = azurerm_resource_group.rg["rg-dev"].name
  location                 = azurerm_resource_group.rg["rg-dev"].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}