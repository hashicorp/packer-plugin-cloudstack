packer {
  required_plugins {
    cloudstack = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/cloudstack"
    }
  }
}

source "cloudstack" "autogenerated_1" {
  api_key                   = "YOUR_API_KEY"
  api_url                   = "https://cloudstack.company.com/client/api"
  disk_offering             = "Small - 20GB"
  hypervisor                = "KVM"
  network                   = "management"
  secret_key                = "YOUR_SECRET_KEY"
  service_offering          = "small"
  source_iso                = "CentOS-7.0-1406-x86_64-Minimal"
  ssh_username              = "root"
  template_display_text     = "Centos7-x86_64 KVM Packer"
  template_featured         = true
  template_name             = "Centos7-x86_64-KVM-Packer"
  template_os               = "Other PV (64-bit)"
  template_password_enabled = true
  template_scalable         = true
  zone                      = "NL1"
}

build {
  sources = ["source.cloudstack.autogenerated_1"]
}
