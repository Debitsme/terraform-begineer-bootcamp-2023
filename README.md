# Terraform Beginner Bootcamp 2023
- The code repo for the below project is [main source code](https://github.com/omenking/terraform-beginner-bootcamp-2023/tree/main)
## Project visualization
![Terratown](https://github.com/Debitsme/terraform-beginner-bootcamp-2023/assets/97181494/464299d5-b848-4091-91a2-3e09ea1414cd)
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

### Modules Sources
- Using the source we can import the module from various places eg:

  locally 
  Github
  Terraform Registry

## Working with Files in Terraform
- Fileexists function
- This is a built in terraform function to check the existance of a file.

``condition = fileexists(var.error_html_filepath)``
[URL](https://developer.hashicorp.com/terraform/language/functions/fileexists)
- filemd link
[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

## Path Variable (important)
- TF provide with a cli command **terraform console** to debug different issue. We will use this to take advantage of the following below commands
- In terraform there is a special variable called path that allows us to reference local paths:
``path.module = get the path for the current module
path.root = get the path for the root module Special Path Variable``

### How to get the URL of an object from s3 bucket
-  For this we will use endpoint variable from the s3 bucket block in tf

## Need for the etag
- The issue here is that tfstate check the resource and not the data so if we will change the data inside the index.htl and rerun it. Nothings will be changed.
- For this purpose we will use etags
  ``source = "${path.root}/public/error.html"``
- its a function that will create a hash based on the content of the file
  ``etag = filemd5("${path.root}/public/error.html")``

### Terraform Data Sources
- In simple this allows us to source data from cloud resources.
- Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.
- [URL](https://developer.hashicorp.com/terraform/language/data-sources)
- Example (# For the S3_policy we use, we need a distribution and an account id. Account ID has been taken care of by the data block as we are already familiar with aws sts get-caller-identity. the distribution id will be taken from the cloud_front distribution block)
- It has a data block in the main.tf and its reference to resource_storage.tf.

### Terraform locals
- Allow us to define local varibles which is very useful when we want to define data in some other format.
### ISSUE_Declaring content type for a file.
- Our code do create a distribution but when we hit the distribution domain name instead of 
- showing us a page we download the file bcz it doesn't know the content of the files.

### Invalidation for cloud_front
- To apply the above changes we need to clear cache in the AWS_CDN.
- Validation --> /*

### jsonencode
- We use the jsonencode to define our bucket policy that is inline with hcl format.

### How to retain cloud front distribution


### Controling the lifecycle of our resources.
[URL](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)
- It allows us to control when a resource is created or updated.
- Mostly when we make any changes inside our html file a version gets attachted to it as we have defined an etag
- What we can do is define a block inside the s3 object like this
``` 
lifecycle {
    ignore_changes = [etag]
  }
```

### reource data block in terraform 
- [URL](https://developer.hashicorp.com/terraform/language/resources/terraform-data)
- The **terraform_data** block is used to create a custom data source within Terraform. This allows you to retrieve and use data from within your configuration
- This data source can then be referenced in other parts of the configuration.
- **data** block in terraform allows us to fetch data from external providers while **terraform_data** allows you to define your own custom data sources within your configuration.
- We have defined content-version and it will only make a change when we change its value instead of the etag as define in the lifecycle block.
```
resource "terraform_data" "content_version" {
  input = var.content_version
}
```
- For knowledge  ---> Before that we were using **null_data**
- Also it doesn't require us to download a provider.

### Heredoc
- Most programming language have this concept and it allow us to run a multi line command in chunk
- [URL](https://developer.hashicorp.com/terraform/language/expressions/strings)
```
command = <<COMMAND
aws cloudfront create-invalidation \
--distribution-id ${aws_cloudfront_distribution.s3_distribution.id} \
--paths '/*'
    COMMAND```

### Provisioners
- They allow us to execute commmands on instances. Terraform don't recommned us to do that as ansible like tools are best fit for them.
- **local-exec** vs **remote-exec** vs **file-exec**
- local will execute command on the machine running your terraform and where you use the commands like terraform plan.
- Remote will execute commnad to other machines where you would like to do ssh.
- File will copy the files and directories from your machine to other machines.

### uploading multiple files
- Earlier in the porject we have single files and now we will shift towards uplaoding multiple files(pictures).
- We will do that usign **iteration**.
- 

#### Terraform for_each and other function
- [URL](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [function](https://developer.hashicorp.com/terraform/language/functions/file)
- We face the challenge of uploading different types of images to s3 so we are using for_each to iterate over alot of things.
- We added a new resource block to uplaod picture and we discover diferent types of pictures from the command below. To find the pictures.
- ```fileset("${path.root}/public/assets","*.{jpg,jpeg}")```
- It(file/fileset) comes under the DSA of the terraform and above define is a list. It will return a key. If its a map/object then it will be returning a value.
- ```${each.key} and each.value```


