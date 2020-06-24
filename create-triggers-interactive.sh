#!/bin/sh
###################################################################################
# Register Tekton Triggers in a project using IBM Garage Cloud Native Toolkit
#
# Author : Cong Nguyen
# email  : cong.nguyen@au1.ibm.com
#
###################################################################################
echo "Registring Tekton triggers..."

echo "Enter app name:"
read -r APP_NAME
echo "Enter existing pipeline name:"
read -r PIPELINE_NAME
echo "Enter image url:"
read -r DOCKER_IMAGE
echo "Enter git repo url:"
read -r GIT_REPO_LINK

# Apply the yaml to cluster
cat 01_binding.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | kubectl apply -f -
cat 02_template.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | sed "s@#PIPELINE_NAME@${PIPELINE_NAME}@g"| sed "s@#DOCKER_IMAGE@${DOCKER_IMAGE}@g"| sed "s@#GIT_REPO_LINK@${GIT_REPO_LINK}@g"| kubectl apply -f -
cat 03_event_listener.yaml | sed "s/#APP_NAME/${APP_NAME}/g" | kubectl apply -f -

echo "Tekton triggers registered."