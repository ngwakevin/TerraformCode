## Create a simple Terraform configuration
## Create a directory named terraform and then a directory under that named hello-world.

mkdir -p terraform/hello-world
cd terraform/hello-world
## Create a file named main.tf.

touch main.tf

##Copy in the following Terraform configuration.

resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "eastus"
}
#This configuration uses the Azure provider to create an Azure Resource Group.

#Before creating the resource, the hello-world directory must be initialized. The initialization process ensures that the proper Terraform provider plugins, Azure, in this case, have been downloaded.

#Use terraform init to initialize the directory.

terraform init

#Use the terraform apply command to run the configuration. Terraform will produce a plan that indicates all resources that will be created, modified, or destroyed. You can then accept the plan to created the resources.

terraform apply

#To validate resource creation, use the Azure CLI az group list command.

$ az group list -o table

Name             Location    Status
---------------  ----------  ---------
hello-world      eastus      Succeeded
Now that the Terraform configuration has been applied, the configuration can be destroyed using the terraform destroy command.

terraform destroy