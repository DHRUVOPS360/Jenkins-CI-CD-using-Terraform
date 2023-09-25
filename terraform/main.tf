resource "google_storage_bucket" "auto-expire" {
  name          = "demo-bucket" //Change the name as per your choice
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
  name         = "my-compute-instance"
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
  network = "projects/<project-id>/global/networks/default"
  subnetwork = "projects/<project-id>/regions/us-central1/subnetworks/default"
  access_config {
      // ...
  }
}
  
  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}
