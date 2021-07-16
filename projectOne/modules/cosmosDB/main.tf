resource "azurerm_cosmosdb_account" "db" {
  name                = "tfex-cosmos-db"
  location            = "West US"
  resource_group_name = "${var.resource_group_name}"
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

    consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
  location          = "West US"
  failover_priority = 1
  }
}
