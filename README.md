### Terraform script to deploy Atlas/AWS resources

## Contents:

1. provider.tf

Uses mongodb atlas terraform provider 1.14.0, aws provider version 5.31.0 and terraform latest.

2. iamrole.tf

Creates Atlas/AWS integration. Generates external ID from Atlas project, Creates IAM role in AWS with trust relationship to Atlas account using external ID.
Allows IAM role to access CMK.
Authorizes role for BYOK setup.
Outputs Atlas Role ID.

3. project.tf

Configures Aws Customer Managed Key on MongoDB Atlas project.
Creates a new database user with atlasAdmin previlleges.
Allows all public networks to access the databases within the project.


4. variables.tf

List of all variables.