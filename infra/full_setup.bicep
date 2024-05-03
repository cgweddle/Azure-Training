
param sku string = 'S0'
param location string = 'eastus'


param skuKind string='OpenAI'
param openAiName string = 'OpenAIWeddle'
param gptName string = 'gpt-weddle'
param embeddingName string = 'embedding-weddle'
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


resource openai 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openAiName
  location: location
  sku: {
    name: sku
    tier: 'Standard'
  }
  kind: skuKind
}

resource openaiDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: gptName
  parent: openai
  sku: {
    name: 'Standard'
    capacity: 50
  }
  properties: {
    model: {
      name: 'gpt-4'
      version: '0125-Preview'
      format: 'OpenAI'
    }
  }
}

resource embeddingDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: embeddingName
  parent: openai
  sku: {
    name: 'Standard'
    capacity: 50
  }
  properties: {
    model: {
      name: 'text-embedding-ada-002'
      version: '2'
      format: 'OpenAI'
    }
  }
}
