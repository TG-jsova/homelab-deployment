# locals.tf
# -------------------------------------------------------------------------------------------------------------------- #
locals {
  windows_vm_configs = [
    {
      vm_name   = "VERGE-TEST01"
      cpu_count = "4"
      memory    = "8192"
      description = "Verge Test 01"
      ip_address = "192.168.0.18"
    },
    {
      vm_name   = "VERGE-TEST02"
      cpu_count = "4"
      memory    = "8192"
      description = "Verge Test 02"
      ip_address = "192.168.0.19"
    },
    {
      vm_name   = "VERGE-TEST03"
      cpu_count = "4"
      memory    = "8192"
      description = "Verge Test 03"
      ip_address = "192.168.0.20"
    },
    {
      vm_name   = "CORP4141-DC02"
      cpu_count = "4"
      memory    = "8192"
      description = "Secondary Domain Controller"
      ip_address = "192.168.0.30"
    }
  ]
}
# -------------------------------------------------------------------------------------------------------------------- #