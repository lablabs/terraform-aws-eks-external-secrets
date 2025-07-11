/**
 * # AWS EKS External Secrets Terraform module
 *
 * A Terraform module to deploy the [External Secrets Operator](https://external-secrets.io/latest/) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-external-secrets/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name      = "external-secrets"
    namespace = "kube-system"

    helm_chart_version = "0.14.2"
    helm_repo_url      = "https://charts.external-secrets.io"
  }

  addon_values = yamlencode({})

  addon_depends_on = []
}
