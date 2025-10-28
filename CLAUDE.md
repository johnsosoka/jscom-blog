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

### Theme Development (jscom-ice)

The jscom-ice theme is a separate repository that's published as a Ruby gem. To develop theme changes locally and test them in jscom-blog:

#### Setup for Local Theme Development

1. **Switch to local theme path** in `website/Gemfile`:
   ```ruby
   group :jekyll_plugins do
     # jscom theme - using local path for development
     gem "jscom_ice", path: "../../jscom-ice"
   end
   ```

2. **Install with local path:**
   ```bash
   cd website
   bundle install
   ```

#### Development Workflow

1. **Start Jekyll with live reload:**
   ```bash
   cd website
   bundle exec jekyll serve --livereload --port 4000
   ```

2. **Edit theme files** in `jscom-ice/` directory:
   - `_includes/` - HTML partials (navbar, footer, etc.)
   - `_layouts/` - Page layouts (default, home, post, etc.)
   - `_sass/` - Stylesheets (SCSS)
   - `assets/` - JavaScript, CSS, images

3. **Restart Jekyll** after theme changes (Jekyll caches theme assets):
   - Stop server (Ctrl+C)
   - Restart with `bundle exec jekyll serve --livereload --port 4000`
   - Hard refresh browser (Cmd+Shift+R or Ctrl+Shift+R)

4. **Test changes** at http://localhost:4000
   - LiveReload will auto-refresh for content changes
   - Manual restart needed for theme asset changes

#### Publishing Theme Updates

When theme changes are ready for production:

1. **Revert Gemfile** to use published version:
   ```ruby
   gem "jscom_ice", '~> 0.0.8'
   ```

2. **In jscom-ice repository:**
   ```bash
   cd ../../jscom-ice

   # Update version in jscom_ice_theme.gemspec
   # spec.version = "0.0.8"

   # Build gem
   gem build jscom_ice_theme.gemspec

   # Push to RubyGems (requires credentials)
   gem push jscom_ice-0.0.8.gem

   # Commit and tag
   git add .
   git commit -m "Release v0.0.8"
   git tag v0.0.8
   git push origin main --tags
   ```

3. **In jscom-blog repository:**
   ```bash
   cd website
   bundle update jscom_ice
   bundle exec jekyll serve  # Test with published gem

   # Commit and deploy
   git add Gemfile Gemfile.lock
   git commit -m "Update jscom_ice theme to v0.0.8"
   git push origin main  # Triggers production deployment
   ```

#### Theme File Locations

**jscom-ice structure:**
```
jscom-ice/
├── _includes/           # Reusable HTML components
│   ├── navbar.html     # Navigation bar
│   ├── footer.html     # Site footer
│   ├── header.html     # HTML head section
│   └── scripts.html    # JavaScript includes
├── _layouts/            # Page templates
│   ├── default.html    # Base layout
│   ├── home.html       # Homepage layout
│   ├── post.html       # Blog post layout
│   └── page.html       # Static page layout
├── _sass/               # Stylesheets (SCSS)
│   ├── base/           # Base styles, typography
│   ├── component/      # Component styles (navbar, posts, etc.)
│   ├── layout/         # Layout styles (footer, etc.)
│   └── pages/          # Page-specific styles
└── assets/              # Static assets
    ├── css/            # Compiled CSS, Bootstrap
    └── js/             # JavaScript files
```

**jscom-blog overrides:**
- `website/_includes/` - Can override theme includes
- `website/_data/` - Site-specific data (menus.yml, carousels.yml)
- `website/_config.yml` - Jekyll and theme configuration

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
