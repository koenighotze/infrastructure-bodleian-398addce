# output "google_cloud_run_service_backend_id" {
#   value = google_cloud_run_service.backend.id
# }

# output "google_cloud_run_service_backend_url" {
#   value = google_cloud_run_service.backend.status[0].url
# }

output "backend_repository_name" {
  value = module.backend_repository.name
}

output "frontend_repository_name" {
  value = module.frontend_repository.name
}
