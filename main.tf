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

resource "azuredevops_build_definition" "build-def1" {
  name               = "build-def-CI"
  project_id         = azuredevops_project.project.id

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = azuredevops_git_repository.repo.id
    branch_name = azuredevops_git_repository.repo.default_branch
    yml_path    = "azure-pipelines.yml"
  }

  #  variable_groups = [
  # azuredevops_variable_group.vars.id
  #  ]

  variable {
    name  = "PipelineVariable"
    value = "Go Microsoft!"
  }

  variable {
    name      = "PipelineSecret"
    secret_value     = "ZGV2cw"
    is_secret = true
  }
}
~
~
~
