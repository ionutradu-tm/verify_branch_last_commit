#!/bin/bash

#VARS
REPO_USER=${WERCKER_VERIFY_BRANCH_LAST_COMMIT_REPO_USER}
REPO1_NAME=${WERCKER_VERIFY_BRANCH_LAST_COMMIT_REPO1_NAME}
REPO2_NAME=${WERCKER_VERIFY_BRANCH_LAST_COMMIT_REPO2_NAME}
TOKEN=${WERCKER_VERIFY_BRANCH_LAST_COMMIT_TOKEN}
BRANCH=${WERCKER_VERIFY_BRANCH_LAST_COMMIT_BRANCH}
#ENDVARS



#check vars

if [[ -z ${REPO_USER} ]]; then
    echo "Please provide repo username"
    exit 1
fi
if [[ -z ${REPO1_NAME} ]]; then
    echo "Please provide repo name"
    exit 1
fi
if [[ -z ${TOKEN} ]]; then
    echo "Please provide github token"
    exit 1
fi
if [[ -z ${REPO2_NAME} ]]; then
    echo "Please provide repo2 name"
    exit 1
fi
if [[ -z ${BRANCH} ]]; then
    echo "Please provide commit to be checked"
    exit 1
fi
#end check

LATEST_COMMIT_1=$(curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/repos/${REPO_USER}/${REPO1_NAME}/commits/${BRANCH} | jq ".sha"| tr -d \")
LATEST_COMMIT_2=$(curl -s -H "Authorization: token ${TOKEN}" https://api.github.com/repos/${REPO_USER}/${REPO2_NAME}/commits/${BRANCH} | jq ".sha"| tr -d \")

if [[ "${LATEST_COMMIT_1}" != "${LATEST_COMMIT_1}" ]];then
        echo "The latest commit: ${LATEST_COMMIT_1} of ${REPO1_NAME}is not the same with the latest commit: ${LATEST_COMMIT_2} of  ${REPO2_NAME}"
        exit 1
fi