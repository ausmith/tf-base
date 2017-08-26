# tf-base

Manage the overall AWS configuration here.

## Terraform

Used to bring the site online easily while managing the config
for the AWS resources.

## Contents

This includes configuration for:

* VPC
* Subnets
* Route tables
* S3 Bucket for bucket logging
* S3 Bucket for site logs
* Security Groups
* S3 Endpoint

Feel free to use this terraform code as examples for your own work!

## Setup

Use the tf state initializer script to ensure your account is setup.

```
./init_tf_state_resources.sh
```

## Usage

### Testing

```
# Setup the tf variables properly
source vars.default

# See the tf output from running `terraform plan`
make test-plan

# Apply the terraform config for test env
make test-apply

# Destroy the test generated resources, AWS destruction may take time
make test-teardown
```

### Prod

```
# Setup the tf variables properly
source vars.default

# See the tf output from running `terraform plan`
make prod-plan

# Apply the terraform config for prod env
make prod-apply
```

You can destroy the prod environment with the make targets as well,
but am intentionally avoiding a make target for that command.

## Troubleshooting

Error message: `provider.XXX: no suitable version installed`

The terraform provider has not been downloaded yet. To fix this, run
`make tf-init` to skip the validation step and ensure correct version
of the providers has been downloaded locally.
