#!/bin/bash

#VARS
#REPO_USER
#REPO_NAME
#TOKEN github token
#COMMIT got commit to check
#BRANCH
#ENDVARS



#check vars

if [[ -z ${REPO_USER} ]]; then
    echo "Please provide repo username"
    exit 1
fi
if [[ -z ${REPO_NAME} ]]; then
    echo "Please provide repo name"
    exit 1
fi
if [[ -z ${TOKEN} ]]; then
    echo "Please provide github token"
    exit 1
fi
if [[ -z ${COMMIT} ]]; then
    echo "Please provide commit to be checked"
    exit 1
fi
if [[ -z ${BRANCH} ]]; then
    echo "Please provide commit to be checked"
    exit 1
fi
#end check
if [[ ${FORCE,,} != "yes" ]];then
  LATEST_COMMIT=$(curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/repos/${REPO_USER}/${REPO_NAME}/commits/${BRANCH} | jq ".sha"| tr -d \")
  echo "LATEST_COMMIT:$LATEST_COMMIT"

  if [[ "${COMMIT}" != "${LATEST_COMMIT}" ]];then
          echo "${COMMIT} is not the latest commit on reppository ${REPO_NAME}, branch ${BRANCH}"
          exit 1
  fi
fi