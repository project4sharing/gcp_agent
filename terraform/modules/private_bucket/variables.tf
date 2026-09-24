variable "project_id" {
  type = string
}

variable "name" {
  description = "Globally unique bucket name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9._-]{1,61}[a-z0-9]$", var.name))
    error_message = "Bucket names must be 3-63 chars: lowercase letters, digits, '-', '_' or '.'."
  }
}

variable "location" {
  description = "A single GCP region (e.g. us-central1). Multi/dual-regions are rejected."
  type        = string

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]+$", var.location))
    error_message = "location must be a single region like 'us-central1' or 'europe-west1' (not US, EU, NAM4...)."
  }
}

variable "storage_class" {
  type    = string
  default = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "storage_class must be STANDARD, NEARLINE, COLDLINE or ARCHIVE."
  }
}

variable "versioning_enabled" {
  type    = bool
  default = true
}

variable "noncurrent_version_retention_days" {
  description = "Delete old object versions after this many days."
  type        = number
  default     = 30
}

variable "force_destroy" {
  description = "Allow `terraform destroy` to delete a bucket that still contains objects."
  type        = bool
  default     = false
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "reader_members" {
  description = "Principals granted roles/storage.objectViewer."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for m in var.reader_members : !contains(["allUsers", "allAuthenticatedUsers"], m)
    ])
    error_message = "Public principals (allUsers, allAuthenticatedUsers) are not allowed on a private bucket."
  }
}
