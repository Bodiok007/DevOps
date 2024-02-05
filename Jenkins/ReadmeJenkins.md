# Terraform Modules

## Structure

1. [Infrustructure](Jenkins/Infrustructure) - contains terraform files to create AWS resources.
2. [Jenkinsfile](Jenkins/Jenkinsfile) - to create pipeline.
3. [install-jenkins.sh](Jenkins/install-jenkins.sh) - to install Jenkins to server.
4. [AppToBuildAndDeploy](https://github.com/Bodiok007/18-app) - repository with app to be used by Jenkins.

## Preparation

1. Apply [Infrustructure](Jenkins/Infrustructure) as described [here](TerraformIntro/ReadmeTerraformIntro.md).
2. On Jenkins machine execute `install-jenkins.sh`.
3. On App machine:
 - install NodeJS
```
sudo apt-get update
sudo apt-get install nodejs npm -y
```
- install PM2
```
sudo npm install pm2 -g
```

## Pipeline stages

1. `Checkout` - clears workspace and pulls files from repository.
2. `Build` - builds app and creates artifacts.
3. `Test` - runs tests.
4. `Deploy` - deployes to App server.

After every build e-mail notification will be sent with:
 - status
 - link to build
 - logs

## Workflow

1. Get password for Jenkins on first run.
![UnlockJenkins](Jenkins/Screenshots/UnlockJenkins.png)

2. Create user.
![CreateJenkinsUser](Jenkins/Screenshots/CreateJenkinsUser.png)

3. Install recommended plugins.

4. Install additionally NodeJS plugin and setup it in Tools.
![ConfigureNodeJS](Jenkins/Screenshots/ConfigureNodeJS.png)

5. Add variables and credentials.
![AddVariables](Jenkins/Screenshots/AddVariables.png)

6. Configure e-mails.
![ConfigureEmails](Jenkins/Screenshots/ConfigureEmails.png)

7. Create pipeline based on [Jenkinsfile](Jenkins/Jenkinsfile).
![PipelineFromJenkinsfile](Jenkins/Screenshots/PipelineFromJenkinsfile.png)

8. Configure web hook on github.
![AddWebHook](Jenkins/Screenshots/AddWebHook.png)

9. Commit new change and check if build triggered.
![CheckWebHook](Jenkins/Screenshots/CheckWebHook.png)
