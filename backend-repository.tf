module "backend_repository" {
  source = "github.com/koenighotze/gcp-tf-modules/github-repository"

  target_repository_name          = "bodleian-service"
  codacy_api_token                = var.codacy_api_token
  docker_registry_username        = "" # does not use docker hub
  docker_registry_token           = "" # does not use docker hub
  project_id                      = var.project_id
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  deployer_service_account_email  = data.google_service_account.backend_service_cicd_sa.email
  github_admin_token              = var.github_admin_token
  github_non_admin_token          = var.github_api_label_token
  terraform_state_bucket          = var.terraform_state_bucket
  container_registry              = var.container_registry
}

resource "github_actions_secret" "service_cloud_run_secrets" {
  for_each = {
    # "CLOUD_RUN_SERVICE"             = google_cloud_run_service.backend.name
    "CLOUD_RUN_REGION"              = var.region
    "RUNTIME_SERVICE_ACCOUNT_EMAIL" = data.google_service_account.backend_runtime_sa.email
    # "SNYK_TOKEN"                    = var.snyk_token
  }

  repository      = module.backend_repository.name
  secret_name     = each.key
  plaintext_value = each.value
}
