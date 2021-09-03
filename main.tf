terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">0.1.0"
    }
  }
}

resource "azuredevops_project" "project" {
  name               = "pcarey_prject"
  description        = "my project terraform"
  work_item_template = "Basic"
  version_control    = "Git"
  visibility         = "private"
}


