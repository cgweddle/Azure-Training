
param sku string = 'S0'
param location string = 'eastus'
param skuKind string='OpenAI'
param openAiName string = 'OpenAIWeddle2'
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


resource openaiDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: gptName
  parent: openai
  sku: {
    name: 'Standard'
    capacity: 20
  }
  properties: {
    model: {
      name: 'gpt-4'
      version: '0125-Preview'
      format: 'OpenAI'
    }
  }
}
