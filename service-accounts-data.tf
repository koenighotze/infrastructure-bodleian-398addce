data "google_service_account" "backend_runtime_sa" {
  account_id = "bodleian-backend@${var.project_id}.iam.gserviceaccount.com"
}

data "google_service_account" "backend_service_cicd_sa" {
  account_id = "bodleian-backend-cicd@${var.project_id}.iam.gserviceaccount.com"
}

data "google_service_account" "frontend_runtime_sa" {
  account_id = "bodleian-frontend@${var.project_id}.iam.gserviceaccount.com"
}

data "google_service_account" "frontend_service_cicd_sa" {
  account_id = "bodleian-frontend-cicd@${var.project_id}.iam.gserviceaccount.com"
}
