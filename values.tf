locals {
  values = yamlencode({
    "aws" : {
      "region" : data.aws_region.current.name
    }
  })
}

data "aws_region" "current" {}

data "utils_deep_merge_yaml" "values" {
  count = var.enabled ? 1 : 0
  input = compact([
    local.values,
    var.values
  ])
}
