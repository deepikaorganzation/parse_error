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
param APPINSIGHTS_INSTRUMENTATIONKEY string
param APPLICATIONINSIGHTS_CONNECTION_STRING string
param AzureWebJobsStorage string
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
param CommonAzureServiceClientId string
param CommonAzureServiceClientSecret string
param CommonAzureServiceScope string
param CommonAzureServiceTokenUrl string
param CommonEmailServiceCcEmail string
param CommonEmailServiceFromEmail string
param CommonEmailServiceToEmail string
param CommonEmailServiceUri string
param DataErrorBlobPath string
param Environment string
param ErrorContainerName string
param ErrorPartsMetadataBlobPathPattern string
param HtmlImageUploadUrl string
param HttpTimeOutMinute string
param IgnoredSpecialCharacters string
param ImageUploadUrl string
param InboundContainerName string
param MaxRetryCnt string
param PartsAssetBatchRunInfoTableName string
param PartsAssetPartRunInfoTableName string
param PurgePrtsAsstImgTxTablesSchedule string
param PurgeTime string
param RetryDelayInterval string
param ServiceBusConnectionString string
param VisibilityDelay string
param WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED string
param WEBSITE_VNET_ROUTE_ALL string
param existingKeyVaultName string


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
         {
          name: 'CommonAzureServiceClientId'
          value: CommonAzureServiceClientId
        }
         {
          name: 'CommonAzureServiceClientSecret'
          value: CommonAzureServiceClientSecret
        }
         {
          name: 'CommonAzureServiceScope'
          value: CommonAzureServiceScope
        }
         {
          name: 'CommonAzureServiceTokenUrl'
          value: CommonAzureServiceTokenUrl
        }
         {
          name: 'CommonEmailServiceCcEmail'
          value: CommonEmailServiceCcEmail
        }
         {
          name: 'CommonEmailServiceFromEmail'
          value: CommonEmailServiceFromEmail
        }
         {
          name: 'CommonEmailServiceToEmail'
          value: CommonEmailServiceToEmail
        }
         {
          name: 'CommonEmailServiceUri'
          value: CommonEmailServiceUri
        }
         {
          name: 'DataErrorBlobPath'
          value: DataErrorBlobPath
        }
         {
          name: 'Environment'
          value: Environment
        }
         {
          name: 'ErrorContainerName'
          value: ErrorContainerName
        }
         {
          name: 'ErrorPartsMetadataBlobPathPattern'
          value: ErrorPartsMetadataBlobPathPattern
        }
         {
          name: 'HtmlImageUploadUrl'
          value: HtmlImageUploadUrl
        }
         {
          name: 'HttpTimeOutMinute'
          value: HttpTimeOutMinute
        }
         {
          name: 'IgnoredSpecialCharacters'
          value: IgnoredSpecialCharacters
        }
         {
          name: 'ImageUploadUrl'
          value: ImageUploadUrl
        }
         {
          name: 'InboundContainerName'
          value: InboundContainerName
        }
         {
          name: 'MaxRetryCnt'
          value: MaxRetryCnt
        }
         {
          name: 'PartsAssetBatchRunInfoTableName'
          value: PartsAssetBatchRunInfoTableName
        }
         {
          name: 'PartsAssetPartRunInfoTableName'
          value: PartsAssetPartRunInfoTableName
        }
         {
          name: 'PurgePrtsAsstImgTxTablesSchedule'
          value: PurgePrtsAsstImgTxTablesSchedule
        }
         {
          name: 'PurgeTime'
          value: PurgeTime
        }
         {
          name: 'RetryDelayInterval'
          value: RetryDelayInterval
        }
         {
          name: 'ServiceBusConnectionString'
          value: ServiceBusConnectionString
        }
         {
          name: 'VisibilityDelay'
          value: VisibilityDelay
        }
         {
          name: 'WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED'
          value: WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED
        }
         {
          name: 'WEBSITE_VNET_ROUTE_ALL'
          value: WEBSITE_VNET_ROUTE_ALL
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
