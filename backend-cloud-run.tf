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
      template.0.spec.0.containers.0.image,
      template.0.spec.0.container_concurrency,
      template.0.spec.0.timeout_seconds,
      traffic
      # template[0].metadata[0].annotations["client.knative.dev/user-image"],
      # template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      # template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      # template[0].metadata[0].annotations["run.googleapis.com/sandbox"],
      # metadata[0].annotations["client.knative.dev/user-image"],
      # metadata[0].annotations["run.googleapis.com/client-name"],
      # metadata[0].annotations["run.googleapis.com/client-version"],
      # metadata[0].annotations["run.googleapis.com/launch-stage"],
      # metadata[0].annotations["serving.knative.dev/creator"],
      # metadata[0].annotations["serving.knative.dev/lastModifier"],
      # metadata[0].annotations["run.googleapis.com/ingress-status"],
      # metadata[0].labels["cloud.googleapis.com/location"],
      # template[0].spec[0].containers[0].image
    ]
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


