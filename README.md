# VergeIO Windows Server Deployment

This repository contains Terraform configurations for deploying Windows Server 2022 VMs on VergeIO infrastructure.

## Overview

The deployment creates two Windows Server 2022 VMs with the following specifications:
- VM Names: CORP4141-verge01 and CORP414-verge02
- CPU: 4 cores each
- Memory: 8GB RAM each
- Storage: 100GB disk each
- Network: Connected to External network with DHCP

## Prerequisites

- Terraform >= 1.0.0
- VergeIO infrastructure access
- Windows Server 2022 template available in VergeIO

## Configuration Files

- `providers.tf`: Contains the VergeIO provider configuration
- `main.tf`: Main Terraform configuration for VM deployment
- `variables.tf`: Variable definitions for the deployment

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

### Network Configuration
- Network: External
- Interface: virtio
- DHCP: Enabled

### Storage Configuration
- Interface: virtio-scsi
- Storage Tier: 1
- Media Type: Clone from template

## Maintenance

To destroy the deployment:
```bash
terraform destroy
```

## Notes

- The deployment uses the Windows-Server-2022-Template as the base image
- VMs are configured to use cloud-init for initial configuration
- Network configuration is set to use DHCP for automatic IP assignment
