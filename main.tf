terraform {
  backend "gcs" {
    # bucket = passed via backend-config
    prefix = "terraform/bodleian/state"
  }
}


