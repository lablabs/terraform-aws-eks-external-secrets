module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name               = "vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
}

module "eks_cluster" {
  source  = "cloudposse/eks-cluster/aws"
  version = "0.44.0"

  region     = "eu-central-1"
  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id
  name       = "external_secrets"
}

module "eks_node_group" {
  source  = "cloudposse/eks-node-group/aws"
  version = "0.28.0"

  cluster_name   = "external_secrets"
  instance_types = ["t3.medium"]
  subnet_ids     = module.vpc.public_subnets
  min_size       = 1
  desired_size   = 1
  max_size       = 2
  depends_on     = [module.eks_cluster.kubernetes_config_map_id]
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

module "external_secrets_disabled" {
  source = "../../"

  enabled = false
}

module "external_secrets_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = false
  argo_helm_enabled = false

  helm_release_name = "aws-external-secrets-helm"
  namespace         = "aws-external-secrets-helm"

  values = yamlencode(local.values)

  helm_timeout = 240
  helm_wait    = true
}

module "external_secrets_argo_kubernetes" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = false

  helm_release_name = "aws-external-secrets-argo-kubernetes"
  namespace         = "aws-external-secrets-argo-kubernetes"

  values = yamlencode(local.values)

  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}

module "external_secrets_argo_helm" {
  source = "../../"

  enabled           = true
  argo_enabled      = true
  argo_helm_enabled = true

  helm_release_name = "aws-external-secrets-argo-helm"
  namespace         = "aws-external-secrets-argo-helm"

  values = yamlencode(local.values)

  argo_namespace = "argo"
  argo_sync_policy = {
    "automated" : {}
    "syncOptions" = ["CreateNamespace=true"]
  }
}
