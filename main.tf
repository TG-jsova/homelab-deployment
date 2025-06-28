# VMs data source fetches the VMs from the VergeIO. 

data "vergeio_vms" "Windows_Template" {
  filter_name = "Windows-Server-2022-Template"
}

data "vergeio_networks" "external_network" {
    filter_name="External"
}

# Create three Windows Server VMs
resource "vergeio_vm" "windows_servers" {
  for_each = { for vm in local.windows_vm_configs : vm.vm_name => vm }

  name                = each.value.vm_name
  description         = "Windows Server VM - ${each.value.vm_name}"
  enabled             = true
  allow_hotplug       = true
  os_family           = "windows"
  cpu_cores           = 4
  machine_type        = "q35"
  ram                 = each.value.memory
  cloudinit_datasource = "nocloud"
  powerstate          = true
  guest_agent         = true
  secure_boot         = true
  uefi                = true

  vergeio_drive {
    name             = "${each.value.vm_name}_disk"
    description      = "Cloned OS disk from image"
    media            = "clone"
    media_source     = data.vergeio_vms.Windows_Template.vms[0].drives[0].media_source.key
    preferred_tier   = 1
    interface        = "virtio-scsi"
    enabled          = true
  }

  vergeio_nic {
    name         = "${each.value.vm_name}_nic"
    description  = "${each.value.vm_name} network device"
    vnet         = data.vergeio_networks.external_network.networks[0].id
    enabled      = true
    interface    = "virtio"
  }
  cloudinit_files = [
		{
		name = "user-data",
		contents = templatefile("windows_vm_module/scripts/user-data.windows.yml.tpl", {
			vm_name			= each.value.vm_name,
			domain			= "sovasolutions.us",
			static_ip 		= each.value.ip_address,
			default_gateway = "192.168.0.1",
			dns_servers     = ["192.168.0.29"],
			domain_user		= "SOVASOLUTIONS\\jsova",
			vm_password 	= "DeepRiver4428!!",
			domain_password = "DeepRiver4428!!"
		})
		},
		{
		name = "meta-data",
		contents = templatefile("windows_vm_module/scripts/meta-data.windows.yml.tpl", {
			vm_name			= each.value.vm_name,
			domain			= "sovasolutions.us"
		})
		}
	]
}