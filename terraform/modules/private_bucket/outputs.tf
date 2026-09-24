output "name" {
  value = google_storage_bucket.this.name
}

output "url" {
  description = "gs:// URL of the bucket."
  value       = google_storage_bucket.this.url
}

output "self_link" {
  value = google_storage_bucket.this.self_link
}

output "location" {
  value = google_storage_bucket.this.location
}
