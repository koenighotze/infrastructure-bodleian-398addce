variable "region" {
  type        = string
  sensitive   = false
  default     = "europe-west3"
  description = "The GCP region"
}

variable "project_id" {
  type        = string
  sensitive   = false
  description = "The GCP project id"
}

variable "terraform_state_bucket" {
  type        = string
  sensitive   = false
  description = "Name of the statebucket to be used by this project"
}

variable "location" {
  default = "europe-west3"
}

variable "github_admin_token" {
  type        = string
  sensitive   = true
  description = "The API Token for the GitHub API"
}

variable "github_api_label_token" {
  type        = string
  sensitive   = true
  description = "The API Token for the GitHub API with fewer privileges used for pull requests"
}

variable "workload_identity_provider_name" {
  type        = string
  description = "The name of the workload identity provider"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "The id of the workload identity pool"
}

variable "codacy_api_token" {
  type        = string
  sensitive   = true
  description = "The API token for uploading coverage data"
}

variable "docker_registry_username" {
  type        = string
  sensitive   = true
  description = "The username for uploading images"
}

variable "docker_registry_token" {
  type        = string
  sensitive   = true
  description = "The API token for uploading images"
}

variable "container_registry" {
  type        = string
  sensitive   = false
  description = "The container registry for OCI images"
}

# variable "snyk_token" {
#   TODO
# }
