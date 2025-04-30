moved {
  from = helm_release.argo_application[0]
  to   = module.addon.helm_release.argo_application[0]
}
