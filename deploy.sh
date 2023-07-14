#!/usr/bin/env zsh

export AWS_PROFILE=jscom
# Author: john sosoka
#
# This script builds the website via Jekyll, syncs the generated artifacts to S3 and invalidates cloudfront distributions.
#
# Usage: ./deploy.sh stage | prod
#
# Set the required environment variables in your rc file.
#
# Requires the Following environment variables:
#     WWW_CLOUDFRONT_ID - to id of production www distribution which must be invalidated upon deployment.
#     ROOT_CLOUDFRONT_ID - to id of the root production distribution which must be invalidated upon deployment.
#     STAGE_CLOUDFRONT_ID - to id of stage distribution which must be invalidated upon deployment.
#     WWW_S3_BUCKET_NAME - to name of target production s3 bucket.
#     ROOT_S3_BUCKET_NAME - to name of root production s3 bucket.
#     STAGE_S3_BUCKET_NAME - to name of stage s3 bucket.
#

# Parse the command line argument
if [[ "$#" -ne 1 ]] || [[ "$1" != "stage" && "$1" != "prod" ]]; then
  echo "Usage: $0 stage | prod"
  exit 1
fi

deploy_env=$1
declare -A cloudfront_ids=( ["www"]="" ["root"]="" )
declare -A bucket_names=( ["www"]="" ["root"]="" )

if [[ "$deploy_env" == "prod" ]]; then
  cloudfront_ids=( ["www"]="${WWW_CLOUDFRONT_ID}" ["root"]="${ROOT_CLOUDFRONT_ID}" )
  bucket_names=( ["www"]="${WWW_S3_BUCKET_NAME}" ["root"]="${ROOT_S3_BUCKET_NAME}" )
else
  cloudfront_ids=( ["www"]="${STAGE_CLOUDFRONT_ID}" ["root"]="${STAGE_CLOUDFRONT_ID}" )
  bucket_names=( ["www"]="${STAGE_S3_BUCKET_NAME}" ["root"]="${STAGE_S3_BUCKET_NAME}" )
fi

cat soso-banner
echo ""
echo ""

check_jekyll_installed()
{
  if ! command -v jekyll &> /dev/null
  then
    echo "Jekyll is not installed. Please install it and retry."
    exit 1
  fi
  echo "Confirmed: Jekyll is installed."
}

check_site_folder_exists()
{
  if [[ ! -d "_site" ]]; then
    echo "The _site directory does not exist."
    exit 1
  fi
  echo "Confirmed: _site directory exists."
}

check_site_folder_content()
{
  if [ -z "$(ls -A _site)" ]; then
   echo "_site is empty. Please make sure your Jekyll build is successful and outputs to _site."
   exit 1
  fi
  echo "Confirmed: _site directory has content."
}

build_artifacts()
{
  echo "Building ${bucket_names[www]}.. artifacts"
  if bundle exec jekyll build
  then
    echo "Successfully built artifacts..."
  else
    echo "Something went wrong executing jekyll build. Please check jekyll log for more details."
    echo "Exiting..."
    exit 1
  fi
}

sync_artifacts_to_s3()
{
  local target_bucket=$1
  echo "syncing assets to target bucket: ${target_bucket}"
  if aws s3 sync ./_site/ s3://"${target_bucket}"
  then
    echo "Assets uploaded to bucket: ${target_bucket}"
  else
    echo "Something went wrong syncing artifacts to bucket. Check aws-cli output for more details."
    echo "Exiting..."
    exit 1
  fi
}

invalidate_cloudfront_distribution()
{
  local dist_id=$1
  echo "Invalidating cloudfront distribution: ${dist_id}"
  aws cloudfront create-invalidation --distribution-id "${dist_id}" --paths "/*"
}

check_bucket_names()
{
  if [[ -z "${bucket_names[www]}" ]] || [[ -z "${bucket_names[root]}" ]]
  then
    echo "Either WWW_S3_BUCKET_NAME or ROOT_S3_BUCKET_NAME is not set."
    echo "Please run the configure_deployer.sh script to set them."
    exit 1
  fi
}

check_cloudfront_ids()
{
  if [[ -z "${cloudfront_ids[www]}" ]] || [[ -z "${cloudfront_ids[root]}" ]]
  then
    echo "Either WWW_CLOUDFRONT_ID or ROOT_CLOUDFRONT_ID is not set."
    echo "Please run the configure_deployer.sh script to set them."
    exit 1
  fi
}

cd website
# Pre-flight checks
check_jekyll_installed
check_bucket_names
check_cloudfront_ids
# Build
build_artifacts
# Verify Output
check_site_folder_exists
check_site_folder_content
# Deploy
sync_artifacts_to_s3 "${bucket_names[www]}"
sync_artifacts_to_s3 "${bucket_names[root]}"
# Invalidate Caches
invalidate_cloudfront_distribution "${cloudfront_ids[www]}"
invalidate_cloudfront_distribution "${cloudfront_ids[root]}"