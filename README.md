# Terraform Beginner Bootcamp 2023
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


