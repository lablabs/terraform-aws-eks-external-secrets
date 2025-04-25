/**
 * # AWS EKS External Secrets Terraform module
 *
 * A terraform module to deploy the External Secrets Operator on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-universal-addon/actions/workflows/pre-commit.yaml)
 */
# FIXME config: update addon docs above
locals {
  # FIXME config: add addon configuration here
  addon = {
    name = "external-secrets"
    namespace = "kube-system"

    helm_chart_name    = "external-secrets"
    helm_chart_version = "0.5.7"
    helm_repo_url      = "https://lablabs.github.i://charts.external-secrets.io"

    argo_kubernetes_manifest_computed_fields = ["metadata.labels", "metadata.annotations"]
  }

  addon_values = yamlencode({
    # FIXME config: add default values here
  })
}
