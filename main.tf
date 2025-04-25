/**
 * # AWS EKS External Secrets Terraform module
 *
 * A terraform module to deploy the External Secrets Operator on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-external-secrets/workflows/pre-commit.yml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/pre-commit.yml)
 */

locals {

  addon = {
    name = "external-secrets"
    namespace = "kube-system"

    helm_chart_name    = "external-secrets"
    helm_chart_version = "0.5.7"
    helm_repo_url      = "https://lablabs.github.i://charts.external-secrets.io"

  }
  
  addon_values = yamlencode({})
}
