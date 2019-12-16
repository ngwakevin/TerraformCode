resource "azurerm_resource_group" "hello-world" {
  name     = "hello-world"
  location = "eastus"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_group" "hello-world" {
  name                = "hello-world"
  location            = azurerm_resource_group.hello-world.location
  resource_group_name = azurerm_resource_group.hello-world.name
  ip_address_type     = "public"
  dns_name_label      = "${azurerm_resource_group.hello-world.name}-${random_integer.ri.result}"
  os_type             = "linux"

  container {
    name   = "hello-world"
    image  = "microsoft/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

## Notice two things about the configuration.

## a. The container instance needs to be created inside of the resource group. To solve this, an expression is used to interpolate the resource group names into the container

## b. The container instance must have a globally unique fully qualified domain name. This is solved using a second Terraform provider named 
#  random to generate a random string that can be appended to a base FQDN name.

# Run terraform init to ensure the directory is initialized.

terraform init

## This time instead of running terraform apply to run the configuration, use terraform plan --out plan.out to visualize what will be created and produce a plan file.

terraform plan --out plan.out

## Use terraform apply plan.out to apply the plan.

terraform apply plan.out