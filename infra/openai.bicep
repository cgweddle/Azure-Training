
param sku string = 'S0'
param location string = 'eastus'
param skuKind string='OpenAI'

resource openAi 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: 'weddleai4'
  location: location
  sku: {
    name: sku
    tier: 'Standard'
  }
  kind: skuKind
}


resource openaiDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  name: 'weddlepgt'
  sku: {
    name: sku
  }
  parent: openAi
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-35-turbo-instruct'
      version: '0914 (Default)'
    }
    raiPolicyName: 'Microsoft.Default'
    versionUpgradeOption: 'OnceCurrentVersionExpired'
  }
}
