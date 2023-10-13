# Build a GitLab CI/CD pipeline that deploys SonarQube to Azure

In this lab you'll learn how to build CI/CD pipelines in GitLab that deploys a SonarQube instance to Azure

## Setup a project in GitLab CI/CD

If you don't have a GitLab account, sign up [here](https://gitlab.com/users/sign_up)

Create a new blank project here (https://gitlab.com/projects/new) 

On the left sidebar, open Settings page of CI/CD and create the following secrets

- `SERVICE_PRINCIPAL_ID`
- `SERVICE_PRINCIPAL_SECRET`
- `TENANT_ID`

## Setup project files

Create the following files, copy content from [here](https://github.com/devops-safari/terraform/tree/main/Lab8)

- `.gitignore`
- `.gitlab-ci.yml`
- `main.tf`
- `outputs.tf`
- `providers.tf`
- `variables.tf`

Edit `main.tf` and add your name to the resource group name (line 2)

Edit `providers.tf` and replace `[your-project-id]` by your actual project id from the main page of your GitLab project, can be found below the project name

Upload your directory to GitLab by running the following commands

```
git init
git remote add origin [your-repo-url]
git add .
git commit -m "Initial commit"
git push -u origin main
```

## Monitor your pipelines

In the left sidebar of your project's page, open Pipelines page under the Build menu

Expect to see a running pipeline with the following stages

- validate
  - fmt : to format your configuration files
  - validate : to lint your configuration files
- test
  - kics-iac-sast : to run security analysis
- build : to run `terraform init` command
- deploy : to run `terraform apply` command

Your pipeline will take around 10 minutes to complete

## Test your SonarQube instance

The `deploy` job is manually triggered, don't forget to run it, open it and expect the following output

```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
public_ip = "SOME IP ADDRESS HERE"

Saving cache for successful job
```

Copy the IP address and open it in your browser, SonarQube need some time to warm up before it responds to web requests, so be a little patient