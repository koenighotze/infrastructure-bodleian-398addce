resource "google_cloud_run_service" "backend" {
  name     = "backend-${random_integer.rand.result}"
  location = var.region

  template {
    spec {
      containers {
        # we need some image to bootstrap the service
        image = "gcr.io/google-samples/hello-app:1.0"
        env {
          name  = "FOO"
          value = "BAR"
        }
        ports {
          container_port = 8080
        }
      }

      container_concurrency = 3
      timeout_seconds       = 3
      service_account_name  = data.google_service_account.backend_runtime_sa.email
    }
  }

  metadata {
    labels = {
      "application" = "bodleian"
      "stage"       = "dev"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


