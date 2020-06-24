#!/bin/sh
###################################################################################
# Register Tekton Triggers in a project using IBM Garage Cloud Native Toolkit
#
# Author : Cong Nguyen
# email  : cong.nguyen@au1.ibm.com
#
###################################################################################
echo "Registering Tekton triggers with an existing pipeline and pipeline resources"
echo "Depends on jq (https://stedolan.github.io/jq/)"

# Specify APP_NAME and PIPELINE_NAME
APP_NAME=$1

if [[ $# -eq 0 ]] ; then
  echo "create-trigger-jq.sh {APP_NAME}"
  exit
fi

# input validation
if [ -z "${APP_NAME}" ]; then
    echo "Please provide APP_NAME as the first parameter"
    exit
fi

PIPELINE_NAME=$APP_NAME
DOCKER_IMAGE=$(tkn res describe ${APP_NAME}-image -o=json | jq '.spec.params[] | select(.name | contains("url")).value' )
GIT_REPO_LINK=$(tkn res describe ${APP_NAME}-git -o=json | jq '.spec.params[] | select(.name | contains("url")).value')

# Apply the yaml to cluster
cat 01_binding.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | kubectl apply -f -
cat 02_template.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | sed "s@#PIPELINE_NAME@${PIPELINE_NAME}@g"| sed "s@#DOCKER_IMAGE@${DOCKER_IMAGE}@g"| sed "s@#GIT_REPO_LINK@${GIT_REPO_LINK}@g"| kubectl apply -f -
cat 03_event_listener.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | kubectl apply -f -

echo "Tekton triggers registered."