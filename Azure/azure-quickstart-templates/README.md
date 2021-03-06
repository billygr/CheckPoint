# Azure Quickstart Templates for Check Point

## Azure Shell

Connect to https://shell.azure.com/

## Check Point Security Management

CloudGuard version R80.20
* BYOD
* Standard D3 v2
* virtualNetworkAddressPrefix 10.0.0.0/16
* subnet1Name Frontend
* subnet1Prefix 10.0.1.0/24
* subnet1StartAddress 10.0.1.10

```bash
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$vmName = Read-Host -Prompt "Enter the VM Name"
$password = Read-Host -Prompt "Enter the admin password"
$adminPassword=ConvertTo-SecureString $password –asplaintext –force

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateUri https://raw.githubusercontent.com/billygr/CheckPoint/master/Azure/azure-quickstart-templates/mgmt/azuredeploy.json `
  -vmName $vmName `
  -adminPassword $adminPassword
```

## Check Point ClougGuard IaaS Single Gateway

CloudGuard version R80.20
* BYOD
* Standard D3 v2
* virtualNetworkName   vnet
* virtualNetworkAddressPrefix  10.0.0.0/16
* subnet1Name  Frontend
* subnet1Prefix 10.0.1.0/24
* subnet1StartAddress 10.0.1.10
* subnet2Name Backend
* subnet2Prefix 10.0.2.0/24
* subnet2StartAddress 10.0.2.10

```bash
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$vmName = Read-Host -Prompt "Enter the VM Name"
$password = Read-Host -Prompt "Enter the admin password"
$sic = Read-Host -Prompt "Enter the One time key for Secure Internal Communication"
$adminPassword=ConvertTo-SecureString $password –asplaintext –force
$sicKey=ConvertTo-SecureString $sic –asplaintext –force

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateUri https://raw.githubusercontent.com/billygr/CheckPoint/master/Azure/azure-quickstart-templates/gw/azuredeploy.json `
  -vmName $vmName `
  -adminPassword $adminPassword `
  -sicKey $sicKey
```

### Notes
If the resource group exists you will get a prompt
Provided resource group already exists. Are you sure you want to update it?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
