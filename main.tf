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

variable "resource_groups" {
  default = ["rg-dev",  "rg-prod"]
}

resource "azurerm_resource_group" "rg" {
  for_each = toset(var.resource_groups)

  name     = each.value
  location = "Central India"
}