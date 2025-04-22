#cloud-config
hostname: ${vm_name}
enable_automatic_updates: False
groups:
  - cloud-users:  [Administrator]
  - windows-group: [local]
users:
  - name: Administrator
    passwd: ${vm_password}
    inactive: False 
  - name: User
    passwd: ${vm_password}
    inactive: False 
write_files:
  - path: c:\cloudbase-init\first-setup.bat
    content: |
      @echo off
      powershell.exe -ExecutionPolicy Bypass -File "C:\cloudbase-init\first-setup.ps1"

  - path: c:\cloudbase-init\first-setup.ps1
    content: |
      Start-Transcript -Path "C:\cloudbase-init\first-setup.txt"
      schtasks /delete /tn "CloudbaseInitFirstBoot" /f
      netsh advfirewall set allprofiles state off
      $ethernet = Get-NetAdapter
      New-NetIPAddress -InterfaceAlias $ethernet.name -IPAddress ${static_ip} -PrefixLength 24 -DefaultGateway ${default_gateway}
      Set-DnsClientServerAddress -InterfaceAlias $ethernet.name -ServerAddresses ${join("\n    - ", dns_servers)}
      Start-Sleep -Seconds 60
      try {
        $DomainFQDN = "${domain}"
        $DomainFQDNsplit = $DomainFQDN.Split(".")
        $DomainName = $DomainFQDNsplit[0]
        $Env = $DomainFQDNsplit[1]
        $DomainSecurePwd = ConvertTo-SecureString '${domain_password}' -AsPlainText -Force
        $DomainUsername = '${domain_user}'
        $DomainCredentials = New-Object System.Management.Automation.PSCredential $DomainUsername,$DomainSecurePwd 
        Write-Output "Add_server_to_Domain: Adding Computer to the domain $DomainFQDN"
        Add-Computer -domain $DomainFQDN -Credential $DomainCredentials -restart
      } catch {
        Write-Error "Add_server_to_Domain: $_"
        Exit
      }
      Write-Output "Add_server_to_Domain: Computer added to the domain $DomainFQDN"
      Stop-Transcript


runcmd:
  - 'schtasks /create /tn "CloudbaseInitFirstBoot" /tr "C:\cloudbase-init\first-setup.bat" /sc onstart /ru SYSTEM'