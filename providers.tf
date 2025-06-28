terraform {
  required_providers {
    vergeio = {
      source = "verge-io/vergeio"
    }
  }
}

provider "vergeio" {
  host     = "verge.sovasolutions.us"
  username = "admin"
  password = ""
  insecure = true  # Required for self-signed certificates
} 