param functionAppName string
param location string
param storageAccountName string
param appServicePlanName string
param applicationInsightsName string
param logAnalyticsWorkspaceName string
param FUNCTIONS_EXTENSION_VERSION string
param FUNCTIONS_WORKER_RUNTIME string
param WEBSITE_RUN_FROM_PACKAGE string
param resourceGroupName string
param AemApiPassword string
param AemApiUserName string
param AemHostName string
param AemMediaAssetUploadPimQueueName string
param AemMediaFolderCreatePimQueueName string
param AemMetaPimQueueName string
param AemUploadFunctionUrl string
param AttachmentUploadUrl string
param AzureStorageConnectionString string
param mfun_sb_sndPrtsAsstImgMediaAssetUpReqToAEM string
param mfun_sb_sndPrtsAsstImgMediaFldrCreReqToAEM string
param mfun_sb_sndPrtsAsstImgMediaToAEM string
param mfun_sch_purgePrtsAsstImgTxTables string


// Fetch the resource ID for the Storage Account dynamically
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' existing = {
  name: storageAccountName
  scope: resourceGroup()
}

 //Fetch the Storage Account Keys
 //var storageAccountKey = listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value

// Construct the Connection String
//var storageConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccountKey};EndpointSuffix=${environment().suffixes.storage}'

// Create a new App Service Plan in the Consumption plan (Dynamic Tier)
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: appServicePlanName // You can use a dynamic name or pass one as a parameter
}

// Fetch the resource ID for Application Insights dynamically
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
  scope: resourceGroup()
}

// Fetch the resource ID of the existing Log Analytics Workspace dynamically
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' existing = {
  name: logAnalyticsWorkspaceName
  scope: resourceGroup('d-rg-apicompute')  
}

// Function App resource
resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: FUNCTIONS_EXTENSION_VERSION // Parameterized
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: FUNCTIONS_WORKER_RUNTIME // Parameterized
        }
        {
          name: 'AzureWebJobsStorage'
          value: AzureWebJobsStorage
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: APPINSIGHTS_INSTRUMENTATIONKEY // Parameterized
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: APPLICATIONINSIGHTS_CONNECTION_STRING
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: WEBSITE_RUN_FROM_PACKAGE // Parameterized
        }


        {
          name: 'AemApiPassword'
          value: AemApiPassword
        }
         {
          name: 'AemApiUserName'
          value: AemApiUserName
        }
         {
          name: 'AemHostName'
          value: AemHostName
        }
         {
          name: 'AemMediaAssetUploadPimQueueName'
          value: AemMediaAssetUploadPimQueueName
        }
         {
          name: 'AemMediaFolderCreatePimQueueName'
          value: AemMediaFolderCreatePimQueueName
        }
         {
          name: 'AemMetaPimQueueName'
          value: AemMetaPimQueueName
        }
         {
          name: 'AemUploadFunctionUrl'
          value: AemUploadFunctionUrl
        }
         {
          name: 'AttachmentUploadUrl'
          value: AttachmentUploadUrl
        }
         {
          name: 'AzureStorageConnectionString'
          value: AzureStorageConnectionString
        }
         {
          name: 'AzureWebJobsmfun_sb_sndPrtsAsstImgMediaAssetUpReqToAEMDisabled'
          value: mfun_sb_sndPrtsAsstImgMediaAssetUpReqToAEM
        }
         {
          name: 'AzureWebJobsmfun_sb_sndPrtsAsstImgMediaFldrCreReqToAEMDisabled'
          value: mfun_sb_sndPrtsAsstImgMediaFldrCreReqToAEM
        }
         {
          name: 'AzureWebJobsmfun_sb_sndPrtsAsstImgMediaToAEMDisabled'
          value: mfun_sb_sndPrtsAsstImgMediaToAEM
        }
         {
          name: 'AzureWebJobsmfun_sch_purgePrtsAsstImgTxTablesDisabled'
          value: mfun_sch_purgePrtsAsstImgTxTables
        }
      ]
      cors: {
        allowedOrigins: [
          'https://portal.azure.com'
        ] // Add portal.azure.com to the allowed origins dynamically
      }
    }
  }
}


// Diagnostic Settings for Function App
  resource diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${functionAppName}-diagnostics'
  scope: functionApp
  properties: {
    logs: [
      {
        category: 'FunctionAppLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsWorkspace.id    
  }
}
output functionAppUrl string = functionApp.properties.defaultHostName
