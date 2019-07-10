# Azure Quickstart Templates for Check Point

## Check Point Security Management

CloudGuard version R80.20
BYOD
Standard D3 v2

Connect to https://shell.azure.com/

$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"

New-AzResourceGroup -Name $resourceGroupName -Location $location
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateUri https://raw.githubusercontent.com/billygr/CheckPoint/master/Azure/azure-quickstart-templates/mgmt/azuredeploy.json
