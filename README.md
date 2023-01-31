# aws-atlas-terraform

## **INDEX**

| S.No. | File Name | Description |
| --- | --- | --- |
| 1. | JenkinsfileProvision | Contains the definition of Jenkins Pipeline. It contains various stages for Mongo cluster creation, VPC peering and secret creation. |
| 2. | JenkinsfileDeprovision | Contains the definition of Jenkins Pipeline to delete an existing Mongo cluster. |
| 3. | create-mongo-secret.sh | Shell script file to create a secret containing Mongo cluster related data in AWS Secrets Manager. |
| 4. | main.tf | Contains the main set of configuration for mongodb module. |
| 5. | variables.tf | Contains the variable definitions for module. |
| 6. | versions.tf |  Specifies the mongodbatlas and aws Provider version and required_version to specify the Terraform template version. |
| 7. | config.tf | Contains backend configuration to store state. |
| 8. | modules/mongodb | Contains main.tf file to create various resources of mongodb. |
| 9. | modules/aws | Contains main.tf file to create various resources of mongodb. |

## **RUN JENKINS PIPELINE**

---

### 1. Create API Key to access Project in Mongo Atlas

To create an API key for a project using the Atlas UI:

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

### 4. Select Atlas region.

### 5. Select Atlas Project from the list.

### 6. Provide Atlas cluster name in format: wo-<env>-<instance>-mongodb Ex. wo-dev-lcap-mongodb.
