terraform {
  backend "s3" {
    # Backend configuration will be provided via environment variables:
    # TF_CLI_ARGS_init="-backend-config=bucket=BUCKET_NAME -backend-config=dynamodb_table=TABLE_NAME -backend-config=region=REGION"

    encrypt = true
    key     = "poc.tfstate"
  }
}