# site-johnsosoka-com
content, assets, jekyll template &amp; terraform required to run https://www.johnsosoka.com

# About

This repository is split into two sections: infrastructure and website. Combined, these can provision & run a copy of
[my homepage](https://johnsosoka.com). Contained in the website directory are some scripts to build & host a local copy
of the website as well as a deployer script. 

### Requirements
* Static site generator, [Jekyll](https://jekyllrb.com/docs/) & dependencies (ruby)
* AWS CLI installed & configured (including credential provisioning)
* Terraform 

## Repository Sections:
For more details on getting the site up & running visit a section's readme:

* **[Infrastructure](/infrastructure)** - Contains terraform to provision all required johnsosoka.com infrastructure.
* **[Website](/website)** - Contains the Jekyll theme & Content for johnsosoka.com


## Todo

* [ ] Deployment Pipelines
  * [ ] Build Artifacts & Sync to prod S3 bucket upon merge to main
  * [ ] Rollback capability??
* [x] Set up terraform s3 backend 
  * [x] S3 bucket for shared output variables & remote state management.
  * [x] DynamoDB table to backend locking mechanism.
* [x] Logging S3 bucket
  * [x] configure website access logging
* [x] Create independent files S3 bucket for keeping hosted download content separate from website content
  * [x] create related cloudfront resources 
  * [x] create related dns entries (route53 resources)