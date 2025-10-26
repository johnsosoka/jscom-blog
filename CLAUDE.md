# CLAUDE.md

## Repository Overview

Personal blog for johnsosoka.com - a Jekyll static site deployed to AWS (S3 + CloudFront) via GitHub Actions.

## Dependencies

- **Shared Infrastructure**: [jscom-core-infrastructure](https://github.com/johnsosoka/jscom-core-infrastructure) (Route53, ACM certificates)
- **Terraform Modules**: [jscom-tf-modules](https://github.com/johnsosoka/jscom-tf-modules) (`static-website` module)
- **Jekyll Theme**: [jscom-ice](https://github.com/johnsosoka/jscom-ice) (custom Ruby gem)

## Repository Structure

```
jscom-blog/
├── website/          # Jekyll site content
│   ├── _config.yml   # Jekyll configuration
│   ├── _posts/       # Blog posts
│   ├── _pages/       # Static pages
│   ├── _data/        # Data files (carousels.yml)
│   ├── _includes/    # Custom includes (carousel.html, posts.html)
│   └── Gemfile       # Ruby dependencies
├── terraform/        # AWS infrastructure (S3, CloudFront, Route53)
└── .github/          # GitHub Actions workflows
```

## Common Tasks

### Local Development

```bash
cd website
bundle install
bundle exec jekyll serve  # http://localhost:4000
```

### Terraform

```bash
cd terraform
AWS_PROFILE=jscom terraform init
AWS_PROFILE=jscom terraform plan
AWS_PROFILE=jscom terraform apply
```

## Deployment

- **Stage**: Manual trigger via GitHub Actions → `stage.johnsosoka.com`
- **Prod**: Auto-deploy on merge to `main` → `johnsosoka.com` & `www.johnsosoka.com`

Both workflows: build Jekyll → sync to S3 → invalidate CloudFront cache

## Custom Components

**Image Carousel**: Configure in `website/_data/carousels.yml`, use with:
```liquid
{% assign carousel = site.data.carousels['carousel-name'] %}
{% include carousel.html images=carousel %}
```

**Post Snippets**: Display category-filtered posts:
```liquid
{% include posts.html category="blog" post_display_limit=5 post_collection_title="Recent Blog Posts" %}
```
