
param sku string = 'S0'
param location string = 'eastus'
param skuKind string='OpenAI'
param openAiName string = 'OpenAIWeddle'
param gptName string = 'gpt-weddle'
param embeddingName string = 'embedding-weddle'

resource openai 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openAiName
  location: location
  sku: {
    name: sku
    tier: 'Standard'
  }
  kind: skuKind
}


resource embeddingDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: embeddingName
  parent: openai
  sku: {
    name: 'Standard'
    capacity: 20
  }
  properties: {
    model: {
      name: 'text-embedding-ada-002'
      version: '2'
      format: 'OpenAI'
    }
  }
}
