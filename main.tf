provider "azuredevops" {}

resource "azuredevops_project" "project" {
  name                = "pcarey_prject"
  description         = "my project terraform"
  template_type_name  = "basic"
  source_control_type = "Git"
  visibility          = "private"
}


