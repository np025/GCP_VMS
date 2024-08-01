# Define the VM for Linux
resource "google_compute_instance" "windows_vm" {
  name         = "my-windows-server-1"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/windows-server-2019-dc-v20210608" 
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

  metadata_startup_script = <<-EOF
    <script>
    <!-- PowerShell script to create a Hello World file -->
    <powershell>
    $filePath = "C:\hello_world.txt"
    $message = "Hello, World!"
    Set-Content -Path $filePath -Value $message
    </powershell>
    </script>
EOF

}

output "instance_ip" {
  value = google_compute_instance.windows_vm.network_interface[0].access_config[0].nat_ip
}
