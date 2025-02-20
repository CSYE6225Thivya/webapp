packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

variable "project_id" {
  type = string
}

variable "source_image_family" {
  type    = string
  default = "centos-stream-8"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "network" {
  type    = string
  default = "default"
}

variable "image_name" {
  type    = string
  default = "custom-image"
}

// variable "credentials_file" {
//   description = "Service Key"
//   default = "tf-gcp-infra-415001-fff167d14bc9.json"
// }



locals {
  timestamp = regex_replace(formatdate("YYYY-MM-DD-hh-mm-ss", timestamp()), "[- TZ:]", "")
}

source "googlecompute" "custom-image" {
  project_id          = var.project_id
  source_image_family = var.source_image_family
  zone                = var.zone
  network             = var.network
  ssh_username        = var.ssh_username
  image_name          = "${var.image_name}-${local.timestamp}"
  // credentials_file    = var.credentials_file

}

build {
  name    = "custom-image-builder"
  sources = ["source.googlecompute.custom-image"]

  provisioner "file" {
    // source      = "/Users/thivya/Desktop/Cloud/Assignment 7/webapp.zip"
    source      = "./webapp.zip"
    destination = "/tmp/webapp.zip"
  }
  provisioner "file" {
    source      = "packer-config/webapp.service"
    destination = "/tmp/webapp.service"
  }
  provisioner "shell" {
    script = "packer-config/install_dependencies.sh"
  }
  provisioner "shell" {
    script = "packer-config/create_user.sh"
  }
  provisioner "shell" {
    script = "packer-config/configure_systemd.sh"
  }
  # Install Ops Agent
  provisioner "shell" {
    inline = [
      "curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh",
      "sudo bash add-google-cloud-ops-agent-repo.sh --also-install",
      "sudo mkdir -p /etc/google-cloud-ops-agent/",
    ]
  }
  provisioner "file" {
    source      = "packer-config/ops-agent-config.yaml"
    destination = "/tmp/ops-agent-config.yaml"
  }
  provisioner "shell" {
    inline = [
      "sudo mv /tmp/ops-agent-config.yaml /etc/google-cloud-ops-agent/config.yaml",
      "sudo systemctl restart google-cloud-ops-agent",
    ]
  }
  post-processors {
    post-processor "manifest" {
      output     = "manifest.json"
      strip_path = true
    }
  }
}





