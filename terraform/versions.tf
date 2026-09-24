terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0, < 8.0"
    }
  }

  # Remote state in GCS. Values come from backend.hcl:
  #   terraform init -backend-config=backend.hcl
  # (GCS backend provides state locking automatically.)
  backend "gcs" {}
}
