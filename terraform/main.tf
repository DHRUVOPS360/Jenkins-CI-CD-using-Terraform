resource "google_storage_bucket" "auto-expire" {
  name          = "engineer-cloud-nprod-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 5
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_compute_instance" "default" {
  name         = "engineer-cloud-nprod-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
  network = "projects/engineer-cloud-nprod/global/networks/default"
  subnetwork = "projects/engineer-cloud-nprod/regions/us-central1/subnetworks/default"
  access_config {
      // ...
  }
}
  
  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}

