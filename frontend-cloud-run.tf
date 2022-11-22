resource "google_cloud_run_service" "frontend" {
  name     = "frontend-${random_integer.rand.result}"
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

      container_concurrency = 2
      timeout_seconds       = 3
      service_account_name  = data.google_service_account.frontend_runtime_sa.email
    }
  }

  metadata {
    labels = {
      "application" = "bodleian"
      "stage"       = "dev"
    }
    annotations = {
      "autoscaling.knative.dev/maxScale" = "3"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
      template.0.spec.0.containers.0.image,
      template.0.spec.0.container_concurrency,
      template.0.spec.0.timeout_seconds,
      traffic
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


