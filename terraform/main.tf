terraform {
  #Pick a provider - could be Azure, AWS etc. You can pick several providers depending on your setup
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}

#configure a provider
provider "docker" {}

#The provider has already chosen specific names which aligns to certain resources. The names above are only for human users
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
  #provider = docker
  #we can set a explicit provider if we do not want to use the default one
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name #Looks at the variable.tf file and finds the specified variable
  ports {
    internal = 80
    external = 8080
  }
}

#terraform init
#Download and install the providers (Docker)

#terraform fmt
# Format your files - for consistency

#terraform validate
# Validate the config - we dont want errors before applying

#terraform apply
# Checks changes required to be made compared to the current configuration - you can still abort here