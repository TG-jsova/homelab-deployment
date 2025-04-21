terraform {
  required_providers {
    vergeio = {
      source = "verge-io/vergeio"
    }
  }
}

provider "vergeio" {
  host     = ""
  username = ""
  password = ""
  insecure = true  # Required for self-signed certificates
} 