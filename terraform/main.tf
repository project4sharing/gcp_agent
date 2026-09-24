resource "google_project_service" "storage" {
  project            = var.project_id
  service            = "storage.googleapis.com"
  disable_on_destroy = false
}

module "private_bucket" {
  source = "./modules/private_bucket"

  project_id     = var.project_id
  name           = var.bucket_name
  location       = var.region
  labels         = var.bucket_labels
  reader_members = var.bucket_reader_members

  depends_on = [google_project_service.storage]
}
