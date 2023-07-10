resource "google_compute_instance" "jenkins_server" {
  name         = "jenkins-server"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Optional. External IP address configuration.
    }
  }

  metadata_startup_script = file("startup-script.sh")
  tags                    = ["deploy-jenkins", "http-server", "jenkins-server-firewall"]
}

resource "google_compute_firewall" "jenkins_server_firewall" {
  name    = "jenkins-server-firewall"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["8000-9000", "22", "3389"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["deploy-jenkins"]
}

output "instance_external_ip" {
  value = google_compute_instance.jenkins_server.network_interface[0].access_config[0].nat_ip
}