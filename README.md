Quick and dirty tekton trigger for cloud native toolkit

1. Run create-triggers.sh with appropriate arguments
2. Run `oc expose svc el-<app_name>`
3. Configure the github webhooks manually by following: ![OpenShift Pipeline Tutorial - Configure Github Webhooks](https://github.com/openshift/pipelines-tutorial#configure-webhook-manually)

See `example.log` for examples.