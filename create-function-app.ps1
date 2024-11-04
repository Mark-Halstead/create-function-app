# Prompt user for input
$resourceGroupName = Read-Host -Prompt "Enter the name for the Resource Group"
$location = Read-Host -Prompt "Enter the location (e.g., EastUS)"
$storageAccountName = Read-Host -Prompt "Enter a unique name for the Storage Account (must be globally unique)"
$functionAppName = Read-Host -Prompt "Enter a name for the Function App"
$runtime = Read-Host -Prompt "Enter the runtime for the Function App (e.g., dotnet, node, python, java)"
$runtimeVersion = Read-Host -Prompt "Enter the runtime version (e.g., 4 for the latest version)"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create a storage account for the Function App
New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                     -Name $storageAccountName `
                     -Location $location `
                     -SkuName Standard_LRS `
                     -Kind StorageV2

# Create the Function App
New-AzFunctionApp -ResourceGroupName $resourceGroupName `
                  -Name $functionAppName `
                  -Location $location `
                  -StorageAccountName $storageAccountName `
                  -Runtime $runtime `
                  -RuntimeVersion $runtimeVersion

# Output Function App URL
Write-Output "Function App URL: https://$functionAppName.azurewebsites.net"
