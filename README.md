# jscom-blog

Welcome to the repository for [John Sosoka's Homepage](https://johnsosoka.com). This repository houses all the necessary 
components, including the blog content, assets, Jekyll template, and Terraform scripts for infrastructure management.

## Repository Structure

Everything required to provision resources, build, and deploy the website is contained within this repository. The contents 
are logically structured into the following directories:

| Directory | Description |
|-----------|-------------|
| [Infrastructure](/infrastructure) | Contains Terraform scripts that provision all necessary AWS resources for the blog. |
| [Website](/website) | Contains the Jekyll theme and the content for the blog. |
| [.github](/.github) | Contains GitHub Actions workflows that automate the deployment of the website. |

Certainly, here's how you can structure the "Getting Started" section with brief steps:

## Getting Started

### Prerequisites

Ensure you have the following installed and configured:

- **Jekyll & dependencies (Ruby):** Install Ruby and then use Ruby's package manager to install Jekyll and Bundler. You can refer to the [Jekyll Documentation](https://jekyllrb.com/docs/installation/) for detailed instructions.
- **AWS CLI:** Download and install the AWS CLI from the [official AWS CLI website](https://aws.amazon.com/cli/). After installation, run `aws configure` in your terminal and follow the prompts to input your AWS credentials.
- **Terraform:** Download the appropriate package for your system from the [Terraform downloads page](https://www.terraform.io/downloads.html). Unzip the package and ensure that the `terraform` binary is available in your `PATH`.

### Running Locally

1. Navigate to the root directory of the project in your terminal.
2. Execute `run-local.sh` to serve the website locally. This will start a local server where you can preview the website.
   ```bash
   ./run-local.sh
   ```
3. Open your web browser and navigate to [http://localhost:4000](http://localhost:4000) to visit the website.

Please note that you might need to grant execute permissions to the `run-local.sh` script before running it. You can do this with the `chmod` command:

```bash
chmod +x run-local.sh
```

## Deployment

### From Local

1. Install and configure the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html).
2. Run `configure_deployer.py` to set the required environment variables for the `deploy.sh` script.
3. Execute `deploy.sh stage | prod` to build the website and sync the contents to the target S3 bucket. This script also attempts to invalidate CloudFront caches.

### GitHub Actions

Deployments to both staging and production environments are automated using GitHub Actions. The workflows for these deployments share the following common steps:

- The workflow checks out the repository and sets up Ruby with the specified version.
- The website is built using Jekyll.
- AWS credentials are configured using the secrets stored in the repository.
- The built site is then uploaded to the specified S3 bucket.
- Finally, the CloudFront distribution is invalidated to refresh the cache.

_Please ensure that the necessary AWS credentials and other secrets are stored in your GitHub repository's secrets section for these workflows to function correctly._

#### Stage Deployment

[![Deploy to STAGE](https://github.com/johnsosoka/jscom-blog/actions/workflows/deploy-stage.yml/badge.svg)](https://github.com/johnsosoka/jscom-blog/actions/workflows/deploy-stage.yml)

The staging deployment is **triggered manually** from the GitHub Actions tab and targets `https://stage.johnsosoka.com`. The workflow file for this process is located at `.github/workflows/deploy-stage.yml`.

#### Prod Deployment

[![Deploy to PROD](https://github.com/johnsosoka/jscom-blog/actions/workflows/deploy-prod.yml/badge.svg?branch=main)](https://github.com/johnsosoka/jscom-blog/actions/workflows/deploy-prod.yml)

The production deployment is **triggered automatically** when a commit is merged to the `main` branch. It targets `https://johnsosoka.com` & `https://www.johnsosoka.com`. The workflow file for this process is located at `.github/workflows/deploy-prod.yml`.

## AWS Website Infrastructure

This repository contains Terraform configuration files to provision the infrastructure required for hosting a website on AWS.
It sets up three CloudFront distributions for the "www", "root", and "stage" subdomains, along with corresponding S3 buckets.
The Terraform state is managed remotely using an S3 backend.

### Resources Provisioned

- CloudFront distributions for "www", "root", and "stage" subdomains
- S3 buckets for the www, root, and staging websites
- IAM user with deployer access and permissions (Used for GitHub Actions CO/CD)
- Route53 records for mapping subdomains to CloudFront distributions

### Usage

1. Install Terraform.
2. Set up your AWS credentials.
3. Modify the variables in `variables.tf` to match your desired configuration.
4. Run `terraform init` to initialize the backend and providers.
5. Run `terraform plan` to preview the infrastructure changes.
6. Run `terraform apply` to provision the AWS resources.

For detailed instructions, refer to the documentation or the comments in the Terraform configuration files.

### Notes

- This infrastructure uses CloudFront as a content delivery network and S3 buckets to host the website content.
- The IAM user created has permissions to manage the S3 buckets and create CloudFront invalidations.
- The Terraform state is managed remotely using an S3 backend.

## Contributing

While this is a personal blog and I don't expect any contributions I do still welcome them. If you have a suggestion or 
would like to contribute a post, please either reach out to me directly or fork this repository and submit a pull request.

## Todo
* [ ] Migrate from Jekyll to Pelican
* [ ] Modernize template/move to bootstrap
* [x] Deployment Pipelines
  * [x] Build Artifacts & Sync to prod S3 bucket upon merge to main
  * ~~[ ] Rollback capability??~~
* [x] Set up stage.johnsosoka.com
* [x] Set up terraform s3 backend
  * [x] S3 bucket for shared output variables & remote state management.
  * [x] DynamoDB table to backend locking mechanism.
* [x] Logging S3 bucket
  * [x] configure website access logging
* [x] Create independent files S3 bucket for keeping hosted download content separate from website content
  * [x] create related cloudfront resources
  * [x] create related dns entries (rout e53 resources)

## License

The Jekyll Template used ([Klisé](/johnsosoka/jscom-blog/blob/main/website/klise.now.sh)) is under the [MIT License](/johnsosoka/jscom-blog/blob/main/website/JEKYLL_TEMPLATE_LICENSE).

All other content is under the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.en.html).