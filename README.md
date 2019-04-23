[![CircleCI](https://circleci.com/gh/vision-i40/infra.svg?style=svg)](https://circleci.com/gh/vision-i40/infra)

# Vision Infra

## Folder Structure

#### **modules/** contains all the reusable modules through the environments

- **modules/customer_registry_service** module with deployment parameterized configuration of [customer registry service](https://github.com/vision-i40/customer_registry_service)
- **modules/gke** module with parameterized GKE cluster
- **modules/gke_node_pool** module with parameterized GKE node pool

#### **environments** contains environments configurations which use *modules/*

Ex.:

- **environments/staging/common** common configuration of staging environment
- **environments/staging/services** services configuration (such as customer registry service) for staging environment
