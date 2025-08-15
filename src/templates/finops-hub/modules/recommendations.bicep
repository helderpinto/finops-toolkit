// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

import { HubProperties } from 'hub-types.bicep'


//==============================================================================
// Parameters
//==============================================================================

@description('Required. FinOps hub instance to deploy the app to.')
param hub HubProperties


//==============================================================================
// Resources
//==============================================================================

// Register app
module appRegistration 'hub-app.bicep' = {
  name: 'Microsoft.FinOpsHubs.Recommendations_Register'
  params: {
    hub: hub
    publisher: 'Microsoft FinOps hubs'
    namespace: 'Microsoft.FinOpsHubs'
    appName: 'Recommendations'
    displayName: 'FinOps hub custom recommendations'
    appVersion: loadTextContent('ftkver.txt') // cSpell:ignore ftkver
    features: [
      'DataFactory'
      'Storage'
    ]
  }
}

// Upload schema and queries files
module schemaFiles 'hub-storage.bicep' = {
  name: 'Microsoft.FinOpsHubs.Recommendations_Storage.SchemaFiles'
  params: {
    app: appRegistration.outputs.app
    container: 'config'
    files: {
      // cSpell:ignore recommendations
      'schemas/recommendations_1.0.json': loadTextContent('../schemas/recommendations_1.0.json')
      'queries/Recommendations-AdvisorCost.json': loadTextContent('scripts/queries/Recommendations-AdvisorCost.json')
      'queries/Recommendations-BackendlessAppGateways.json': loadTextContent('scripts/queries/Recommendations-BackendlessAppGateways.json')
      'queries/Recommendations-BackendlessLoadBalancers.json': loadTextContent('scripts/queries/Recommendations-BackendlessLoadBalancers.json')
      'queries/Recommendations-EmptySQLElasticPools.json': loadTextContent('scripts/queries/Recommendations-EmptySQLElasticPools.json')
      'queries/Recommendations-NonSpotAKSClusters.json': loadTextContent('scripts/queries/Recommendations-NonSpotAKSClusters.json')
      'queries/Recommendations-SQLVMsWithoutAHB.json': loadTextContent('scripts/queries/Recommendations-SQLVMsWithoutAHB.json')
      'queries/Recommendations-StoppedVMs.json': loadTextContent('scripts/queries/Recommendations-StoppedVMs.json')
      'queries/Recommendations-UnattachedDisks.json': loadTextContent('scripts/queries/Recommendations-UnattachedDisks.json')
      'queries/Recommendations-UnattachedPublicIPs.json': loadTextContent('scripts/queries/Recommendations-UnattachedPublicIPs.json')
      'queries/Recommendations-VMsWithoutAHB.json': loadTextContent('scripts/queries/Recommendations-VMsWithoutAHB.json')
    }
  }
}

//==============================================================================
// Outputs
//==============================================================================

@description('Number of schema files uploaded.')
output schemaFilesUploaded int = schemaFiles.outputs.filesUploaded
