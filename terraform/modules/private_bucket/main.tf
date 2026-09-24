resource "google_storage_bucket" "this" {
  name          = var.name
  project       = var.project_id
  location      = var.location # single region => regional bucket
  storage_class = var.storage_class

  # --- Not exposed to the internet ---------------------------------------
  # Blocks any grant to allUsers / allAuthenticatedUsers, even by an admin.
  public_access_prevention = "enforced"
  # Disables per-object ACLs; access is controlled only by IAM.
  uniform_bucket_level_access = true
  # -----------------------------------------------------------------------

  force_destroy = var.force_destroy

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.versioning_enabled ? [1] : []
    content {
      condition {
        days_since_noncurrent_time = var.noncurrent_version_retention_days
      }
      action {
        type = "Delete"
      }
    }
  }

  labels = var.labels
}

resource "google_storage_bucket_iam_member" "readers" {
  for_each = toset(var.reader_members)

  bucket = google_storage_bucket.this.name
  role   = "roles/storage.objectViewer"
  member = each.value
}
