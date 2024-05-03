
param location string = 'eastus'
param storage_name string = 'weddlestorage'
param containerName string = 'beigebooks'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = { 
  name: storage_name
  location: location 
  sku: { 
    name: 'Standard_LRS'
  } 
  kind: 'StorageV2' 
  properties: { 
    accessTier: 'Hot' 
  } 
} 
  
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = { 
  name: containerName
  parent: blobServices
}
