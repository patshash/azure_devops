resource "azuredevops_build_definition" "build-def1" {
  name               = "build-def-CI"
  project_id         = "${azuredevops_project.project.name}"
  buildnumber_format = "1.0$(rev:.r)"                        #Optionnal
  badge_enabled      = false                                 #Optionnal (default true)
  description        = "It' definition created by Terraform"

  repository {
    name   = "${azuredevops_project.project.name}"
    type   = "TfsGit"
    branch = "master"
  }

  variables {
    variable {
      name  = "test3"
      value = "ok"
    }

    variable {
      name      = "test4"
      value     = "ok2"
      is_secret = true
    }
  }

  # Need to create this
  #  queue {
  #    pool_name = "Hosted VS2017"
  #  }

  designer_phase {
    name = "phase1"

    step {
      display_name   = "teststep"
      task_id        = "d9bafed4-0b18-4f58-968d-86655b4d2ce9"
      task_version   = "2.*"
      always_run     = false
      reference_name = "testouput"

      inputs = {
        failOnStderr     = "false"
        script           = "echo Write your commands here\necho Use the environment variables input below to pass secret variables to this script"
        workingDirectory = ""
      }
    }

    step {
      display_name       = "teststep2"
      task_id            = "d9bafed4-0b18-4f58-968d-86655b4d2ce9"
      task_version       = "2.*"
      enabled            = false                                  #Optionnal
      continue_on_error  = false                                  #Optionnal
      condition          = "always()"                             #Optionnal
      timeout_in_minutes = 50                                     #Optionnal

      inputs = {
        failOnStderr     = "false"
        script           = "echo Write your step 2"
        workingDirectory = "$$(Buid.SourcesDirectory)"
      }

      #Optionnal
      environment_variables = {
        var1 = "key1"
        var2 = "key2"
      }
    }
  }
}

