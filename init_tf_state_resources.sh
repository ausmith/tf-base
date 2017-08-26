#!/bin/bash

set -euo pipefail

bucket_name="ausmith-tf-state"
table_name="ausmith-tf-state-locks"

if [[ "$(aws s3api list-buckets --query "Buckets[].Name" | grep -c "${bucket_name}")" != "1" ]]; then
  # Create the state bucket
  aws s3api create-bucket --bucket "${bucket_name}" \
                          --acl private \
                          --region "us-east-1"

  # Ensure bucket versioning is present
  aws s3api put-bucket-versioning --bucket "${bucket_name}" \
                                  --versioning-configuration Status=Enabled
fi

if [[ "$(aws dynamodb list-tables --query "TableNames[]" | grep -c "${table_name}")" != "1" ]]; then
  # Create the dynamodb tf state lock table
  aws dynamodb create-table --table-name "${table_name}" \
                            --attribute-definitions AttributeName=LockID,AttributeType=S \
                            --key-schema AttributeName=LockID,KeyType=HASH \
                            --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
fi
