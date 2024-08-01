# Define the VM for Linux
resource "google_compute_instance" "linux_vm" {
  name         = "my-linux-server-1"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts" # Ubuntu 22.04 LTS
    }
  }

  network_interface {
    network = "default"
    access_config {
      // The VM a public IP address
    }
  }

  service_account {
    email  = "test-sa-acc@indigo-tracker-414204.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Hello, World!" > /home/ubuntu/hello.txt
  EOT
}

output "linux_instance_ip" {
  value = google_compute_instance.linux_vm.network_interface[0].access_config[0].nat_ip
}
