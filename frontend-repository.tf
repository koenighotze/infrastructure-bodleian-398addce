module "frontend_repository" {
  #checkov:skip=CKV_TF_1:No sha for the module ref.
  #checkov:skip=CKV_TF_2:No version for the module ref.
  source = "github.com/koenighotze/gcp-tf-modules/github-repository"

  target_repository_name          = "bodleian-frontend"
  codacy_api_token                = var.codacy_api_token
  docker_registry_username        = "" # does not use docker hub
  docker_registry_token           = "" # does not use docker hub
  project_id                      = var.project_id
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  deployer_service_account_email  = data.google_service_account.frontend_service_cicd_sa.email
  github_admin_token              = var.github_admin_token
  github_non_admin_token          = var.github_api_label_token
  terraform_state_bucket          = var.terraform_state_bucket
  container_registry              = var.container_registry
}

resource "github_actions_secret" "frontend_repository_secrets" {
  for_each = {
    "CLOUD_RUN_FRONTEND_URL"        = google_cloud_run_service.frontend.status[0].url
    "CLOUD_RUN_REGION"              = var.region
    "CLOUD_RUN_SERVICE"             = google_cloud_run_service.frontend.name
    "GITGUARDIAN_API_KEY"           = var.gitguardian_api_key
    "RUNTIME_SERVICE_ACCOUNT_EMAIL" = data.google_service_account.frontend_runtime_sa.email
    "SLACK_WEBHOOK_URL"             = var.slack_webhook_url
    "SNYK_TOKEN"                    = var.snyk_token
  }

  repository  = module.frontend_repository.name
  secret_name = each.key
  #checkov:skip=CKV_GIT_4:Secrets are allowed in the state.
  plaintext_value = each.value
}

