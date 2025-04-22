# VergeIO Windows Server Deployment

This repository contains Terraform configurations for deploying Windows Server 2022 VMs on VergeIO infrastructure.

## Overview

The deployment creates three Windows Server 2022 VMs with the following specifications:
- VM Names: WIN-VERGE01, WIN-VERGE02, and WIN-VERGE03
- CPU: 4 cores each
- Memory: 8GB RAM each
- Storage: Cloned from Windows-Server-2022-Template
- Network: Connected to External network with virtio interface

## Prerequisites

- Terraform >= 1.0.0
- VergeIO infrastructure access
- Windows Server 2022 template available in VergeIO

## Configuration Files

- `providers.tf`: Contains the VergeIO provider configuration
- `main.tf`: Main Terraform configuration for VM deployment

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

## VM Configuration Details

### Base Configuration
- OS Family: Windows
- Machine Type: q35
- Hotplug Enabled: Yes
- Secure Boot: Enabled
- UEFI: Enabled
- Guest Agent: Enabled
- Cloud-init Datasource: nocloud

### Network Configuration
- Network: External
- Interface: virtio
- DHCP: Enabled (via External network)

### Storage Configuration
- Interface: virtio-scsi
- Storage Tier: 1
- Media Type: Clone from Windows-Server-2022-Template

## Maintenance

To destroy the deployment:
```bash
terraform destroy
```

## Notes

- The deployment uses the Windows-Server-2022-Template as the base image
- VMs are configured to use cloud-init for initial configuration
- Network configuration is set to use the External network
- All VMs have identical hardware specifications (4 cores, 8GB RAM)
