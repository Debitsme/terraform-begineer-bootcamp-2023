# Terraform Beginner Bootcamp 2023
- The code repo for the below project is [main source code](https://github.com/omenking/terraform-beginner-bootcamp-2023/tree/main)
## Semantic versioning  :mage:

I am doing this for fun and there are no catches here.
We will be utilizing semantic versionig for tagging.
This is the link for markdown text on github. [link](https://github.com/github/docs/blob/main/content/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax.md) 


## Terraform refactor issue
- The gitpod automatic installation of terraform was not working so to resolve the issue new installation code has been copied form the terraform docs.
- The new file of with the name of **install_terraform_cli** contains the code for terraform installtion.
- Also a few changed has been made in the gitpod yaml file. The main issue was with the init command which has been replaced with the before command.

## Gitpod command(before, init)
- Issue with the init is that it will nor rerun if we restart our environment.

## define the env varibales

- To define the env varibale we could use the export command in terminal
`` export aws=somthing``
- Tog get the value of the varibale
`` echo $aws ``
- To define the variable inside a script
`` aws=something``
- To get the value of a variable inside a script
`` $aws ``

## To set and persist env inside gitpod
`` gp env aws=something``


### aws cli installion
- AWS cli is already installed
- We need to set specific env for that
- The script to install exist inside the **insall_aws_cli** folder via the bash script.


### To check if our aws credentials are configured correctly
``aws sts get-caller-identity``

#### Set aws env variables
[link](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Random provider
- Most of the time we need to make bucket in s3 and for that we require a unique and we can use **terraform random provider** to generate a name.
- [random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

### Terraform commands
- To initate the directory of the terraform --> **terraform init**
- To confirm the terraform syntac --> **terraform validate** --> it will also run when we use terraform apply 
- To apply the changes ---> **terraform apply**
- To destroy the created resources --> **terraform destroy**
- To confirm which resources will be created without creating them --> **terraform plan**

### terraform providers
- They are kind of middle man to make an api call to the infrastructure provider that we wanted to build.

### For remote backend we could use either S3 or terraform cloud
- There is an issue we face while authenticating to terraform cloud
- To avoid that we need to create a script and I have created a script with the name of **generate_tfrc_credentials**.
- The path where the script should exist is: 
`` touch /home/gitpod/.terraform.d/credentials.tfrc.json ``
- The following code block should exist inside the file 
`` {
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
} ``

### alert
- We must define our aws access key, secret keys and aws region inside terraform cloud.

### Terraform import
- If somehow we lost the tf state file we can recover the file from **terraform import** commnad.
`` terraform import aws_s3_bucket.bucket_1 bucket _name/resource name ``
- We stop using terraform random provdier as it was causing us some issues.

## How we can reference what we have defined inside the modules in tf
### variables
- We need to define the variables inside the modules files and also in the root directory so that the modules block in the root folder can reference the varibales.
- Also we can make use of the tfvars file or just define these values directly inside the module block
``module "terrahouse" {
  source = "./modules/terrahouse_aws"
   bucket_name=var.bucket_name
   UUID=var.UUID
  
}``

## How do we get stuff into the module and how do we get out of modules.
### outputs
- We also need to define the output inside the modules directory and also inside the root directory of the tf project and we can referecne them through this:
`` output "My_bucket_name" {
  value = aws_s3_bucket.bucket_1.bucket
}``

## Fix using terraform refresh
 - terraform apply -refresh-only