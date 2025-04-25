module "addon_installation_disabled" {
  source = "../../"

  enabled = false
}

locals {
  values = {
    "replicaCount" : 2
    "leaderElect" : true
    "podLabels" : {
      "app" : "external-secrets"
    }
    "affinity" : {
      "podAntiAffinity" : {
        "requiredDuringSchedulingIgnoredDuringExecution" : [
          {
            "labelSelector" : {
              "matchExpressions" : [
                {
                  "key" : "app"
                  "operator" : "In"
                  "values" : [
                    "external-secrets"
                  ]
                }
              ]
            }
            "topologyKey" : "topology.kubernetes.io/zone"
          }
        ]
      }
    }
  }
}

module "addon_installation_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  values = yamlencode({
    local.values
  })
}

# Please, see README.md and Argo Kubernetes deployment method for implications of using Kubernetes installation method
module "addon_installation_argo_kubernetes" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  values = yamlencode({
    local.values
  })

  argo_sync_policy = {
    automated   = {}
    syncOptions = ["CreateNamespace=true"]
  }
}

module "addon_installation_argo_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true


  argo_sync_policy = {
    automated   = {}
    syncOptions = ["CreateNamespace=true"]
  }
}
