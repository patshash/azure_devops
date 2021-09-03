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

resource "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = "Import an Existing Repository"
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/patshash/azure_devops.git"
  }
}
