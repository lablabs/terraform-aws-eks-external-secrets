# IMPORTANT: Add addon specific variables here
variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "argo_application_use_helm" {
  type        = bool
  default     = false
  description = "If set to true, the ArgoCD Application manifest will be deployed using Kubernetes provider as a Helm release. Otherwise it'll be deployed as a Kubernetes manifest. See Readme for more info"
}

variable "argo_application_values" {
  default     = ""
  description = "Value overrides to use when deploying argo application object with helm"
}
