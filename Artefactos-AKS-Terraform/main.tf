# Create a resource group
resource "azurerm_resource_group" "RG" {
  name     = var.ResourceGroup
  location = var.location
}

resource "azurerm_kubernetes_cluster" "K8sCluster" {
  name                = var.ClusterName
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  dns_prefix          = "Cluster-AKS-DNS"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "POC_Semillero"
  }
}

# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.K8sCluster.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.K8sCluster.kube_config_raw

#   sensitive = true
# }