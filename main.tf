# VMs data source fetches the VMsfrom the VergeIO. 

data "vergeio_vms" "Windows_Template" {
  filter_name = "Windows-Server-2022-Template"
}

data "vergeio_networks" "external_network" {
    filter_name="External"
}

resource "vergeio_vm" "this" {
	name            		  = "Windows-Test01"
	description     	    = "Test VM"
	enabled           	  = true
	allow_hotplug			    = true
	os_family       		  = "windows"
	cpu_cores       		  = 4
	machine_type    		  = "q35"
	ram             		  = 8192
	cloudinit_datasource 	= "nocloud"
  	powerstate 				  = true
	guest_agent				    = true
	secure_boot				    = true
	uefi					        = true
	vergeio_drive {
		name            		= "Windows-Test01_disk"
		description     		= "Cloned OS disk from image"
		media           		= "clone"
		media_source    		= data.vergeio_vms.Windows_Template.vms[0].drives[0].media_source.key
		preferred_tier  		= 1
		interface       		= "virtio-scsi"
    	enabled         	= true
	}
	vergeio_nic {
	    name 					= "Windows-Test01_nic"
    	description 	= "Windows-Test01 network device"
    	vnet 					= data.vergeio_networks.external_network.networks[0].id
    	enabled 			= true
    	interface 		= "virtio"
	}
}