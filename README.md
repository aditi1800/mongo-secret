# aws-atlas-terraform

## **DESCRIPTION**

This repository contains code to automate creation of mongo atlas cluster and mongo secret in AWS Secrets Manager. It uses terraform to deploy Mongo Cluster by taking user inputed parameters such as atlas public key, atlas private key, region, atlas project and instance name. After cluster is created, it grabs the values such as connection string, host, etc. from cluster through api and generates secret in AWS Secrets Manager.

You can also create network peering connection by providing aws account id, vpc id of vpc to be peered and IPv4 cidr block of vpc in parameters in jenkins.

For running job in Jenkins, visit WO and then dev in Jenkins. To deploy a mongo cluster, build a job by providing parameters in **MongoDB-deploy** pipeline. And to undeploy an existing mongo cluster, build a job in **MongoDB-undeploy** pipeline.

## **INDEX**

| S.No. | File Name              | Description                                                                                                                          |
| ----- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| 1.    | JenkinsfileProvision   | Contains the definition of Jenkins Pipeline. It contains various stages for Mongo cluster creation, VPC peering and secret creation. |
| 2.    | JenkinsfileDeprovision | Contains the definition of Jenkins Pipeline to delete an existing Mongo cluster.                                                     |
| 3.    | create-mongo-secret.sh | Shell script file to create a secret containing Mongo cluster related data in AWS Secrets Manager.                                   |
| 4.    | main.tf                | Contains the main set of configuration for mongodb module.                                                                           |
| 5.    | variables.tf           | Contains the variable definitions for module.                                                                                        |
| 6.    | versions.tf            | Specifies the mongodbatlas and aws Provider version and required_version to specify the Terraform template version.                  |
| 7.    | config.tf              | Contains backend configuration to store state.                                                                                       |
| 8.    | modules/mongodb        | Contains main.tf file to create various resources of mongodb.                                                                        |
| 9.    | modules/aws            | Contains main.tf file to create various resources of mongodb.                                                                        |

## **RUN JENKINS PIPELINE**

### 1. Create API Key to access Project in Mongo Atlas

To create an API key for a project using the Atlas UI:

- Visit https://account.mongodb.com/ and login to Mongodb Atlas Account

  - For logging into dev environment, search for **Mongo Atlas (Dev)** in 1Password
  - For logging into prod environment, search for **Mongo Atlas (Prod)** in 1Password

- Navigate to the Access Manager page for your project.
  If it is not already displayed, select the organization that contains your desired project from the Organizations menu in the navigation bar.

- Select your desired project from the list of projects in the Projects page.

- Click the vertical ellipsis () next to your project name in the upper left corner and select Project Settings.

- Click Access Manager in the navigation bar, then click your project.

- Click Create API Key.

- Enter the API Key Information.
  On the Create API Key page:

- Enter a Description.

- In the Project Permissions menu, select the new role or roles for the API key.

- Click Next.

- Copy and save the Public Key.
  The public key acts as the username when making API requests.

- Copy and save the Private Key.
  The private key acts as the password when making API requests.

- Add an API Access List Entry.
  Click Add Access List Entry.

- Enter an IP address from which you want Atlas to accept API requests for this API Key.

- You can also click Use Current IP Address if the host you are using to access Atlas will also make API requests using this API Key.

- Click Save.

- Click Done.

### 2. Pass values of Public Key and Private in parameters of Jenkins Pipiline.

### 3. Create credentials in Jenkins for AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_SESSION_TOKEN.

### 4. Select the region.

### 5. Select Environment from the drop down list provided i.e. Dev or Prod.

Based on the selection of Environment, corresponding list of projects available in the environment will be displayed.

### 6. Select Atlas Project from the list.

After selecting environment, select one of the project in which cluster needs to be created.

### 7. Provide Atlas instance name in format: wo-<env>-<instance> Ex. wo-dev-lcap.

### 8. Provide instance size for cluster Ex. M10.

Atlas provides different instance sizes, each with a default storage capacity and RAM size. The instance size you select is used for all the data-bearing servers in your cluster.

### 9. Provide disk size in GB. The minimum disk size for dedicated clusters is 10GB.

### 10. VPC Peering (not needed for dev environmet)

To do VPC Peering, provide vpc id and other aws related parameters. If vps id and other aws parameters are not provided, VPC Peering will be not done. For peering VPC and Mongo cluster -

- Provide valid aws account id.

- Provide valid VPC id eg. vpc-xxxxxxxxxx

- Provide valid VPC IPv4 cidr block.
