module "example" {
  source = "../../"

  values = yamlencode({
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
  })
}

module "disabled" {
  source = "../../"

  enabled = false
}
