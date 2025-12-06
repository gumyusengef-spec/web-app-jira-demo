# 1. Terraform Block: Required Providers
# This block specifies the necessary providers Terraform needs to download.
terraform {
  required_providers {
    # The 'null' provider is a HashiCorp provider used for testing and custom logic.
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0" # Constrain the version to ensure compatibility
    }
  }

  # This section defines the backend for storing the state file (optional for local lab)
  # backend "local" {}
}

# 2. Resource Block: Define the infrastructure component
# A null_resource is a dummy resource that allows you to run custom actions.
resource "null_resource" "hello_world_test" {
  # The 'triggers' block forces the resource to be recreated every time 
  # the configuration or a trigger changes. We use timestamp() to ensure 
  # it runs on every 'apply'.
  triggers = {
    timestamp = timestamp()
  }

  # The 'provisioner' block executes actions on the local machine
  provisioner "local-exec" {
    # This command will be executed after the resource is 'created' during 'terraform apply'
    command = "echo '✅ SUCCESS: Terraform executed a local command! Running at: ${null_resource.hello_world_test.triggers.timestamp}'"
  }
}

# 3. Output Block: Display information to the user after apply
# This makes it easy to see the result of the provisioner.
output "test_status" {
  value       = "Provisioning of null_resource was attempted."
  description = "Confirmation that the test resource was processed."
}
