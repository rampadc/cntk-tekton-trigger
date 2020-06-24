# Purpose

Quick and dirty tekton trigger for IBM Garage Cloud Native Toolkit. Tested with OpenShift 4.3.

## Using existing pipeline, resources to extract values and create triggers

Assuming an application was configured with name `inventory-management-ui`. Using `igc pipeline`, a pipeline with the same name would have been created, i.e. pipeline is called `inventory-management-ui`. Additionally, a Git pipeline resource and image pipeline resource were also created with names `inventory-management-ui-git` and `inventory-management-ui-image`. Using this convention, the following script `create-triggers-jq.sh` uses [jq](https://stedolan.github.io/jq/) to parse the pipeline resource definition and extract the established URLs.

1. Run `create-triggers-jq.sh` with the name of the application. For example, `./create-trigger-jq.sh inventory-management-ui`.
2. Run `oc expose svc el-<APP_NAME>`. For example, `oc expose svc el-inventory-management-ui`.
3. Configure the github webhooks manually by following: ![OpenShift Pipeline Tutorial - Configure Github Webhooks](https://github.com/openshift/pipelines-tutorial#configure-webhook-manually). Make sure to set the content type to `application/json`.

## All manual

1. Run create-triggers.sh with appropriate arguments. For example, `./create-trigger.sh inventory-management-ui inventory-management-ui <docker-image> <git link>`
2. Run `oc expose svc el-<app_name>`
3. Configure the github webhooks manually by following: ![OpenShift Pipeline Tutorial - Configure Github Webhooks](https://github.com/openshift/pipelines-tutorial#configure-webhook-manually). Make sure to set the content type to `application/json`.