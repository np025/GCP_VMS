terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

# Specify the provider
provider "google" {
  credentials = file("sa_key.json")
  project     = var.project
  region      = var.region
}
