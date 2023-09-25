terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.58.0"
    }
  }
backend "gcs" {
    bucket  = "my-jenkins-server-backend"
    prefix  = "jenkins-backend"
  }
}

provider "google" {
  project = "your-project-id"
  region  = "us-central1"
  zone    = "us-central1-c"
}
