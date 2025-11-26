terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "e18988e4-e1f4-4f06-9339-c63c8a22d3d9"
  features {}
}