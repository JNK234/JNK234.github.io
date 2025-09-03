# Guide: Displaying External Blog Posts (Medium & Substack)

This guide explains how to display your Medium and Substack blog posts on your al-folio portfolio site.

## Method 1: RSS Feed Integration (Automatic)

### Step 1: Get Your RSS Feed URLs

**For Medium:**
- Your Medium RSS feed: `https://medium.com/@YOUR-USERNAME/feed`
- Replace `YOUR-USERNAME` with your actual Medium username
- Example: `https://medium.com/@narasimhakarthik/feed`

**For Substack:**
- Your Substack RSS feed: `https://YOUR-PUBLICATION.substack.com/feed`
- Replace `YOUR-PUBLICATION` with your Substack publication name
- Example: `https://neuraforge.substack.com/feed`

### Step 2: Update Configuration

Edit `_config.yml` and replace the placeholder URLs with your actual RSS feeds:

```yaml
external_sources:
  - name: Medium
    rss_url: https://medium.com/@YOUR-USERNAME/feed
    
  - name: Substack
    rss_url: https://YOUR-PUBLICATION.substack.com/feed
```

### Step 3: Install Dependencies (if needed)

```bash
bundle install
```

### Step 4: Build and Test

```bash
bundle exec jekyll serve
```

Your external posts will automatically appear in your blog listing with source badges!

## Method 2: Manual Post Addition

### Option A: Using the Script

Run the helper script to add individual posts:

```bash
ruby _scripts/add-external-post.rb
```

Follow the prompts to enter:
- Post title
- External URL
- Source (Medium/Substack/Other)
- Published date
- Description
- Tags
- Categories

### Option B: Manual File Creation

Create a new file in `_posts/` directory:

```markdown
---
layout: external-post
title: "Your Article Title"
date: 2024-01-15 00:00:00 +0000
description: "Brief description of your article"
external_source: Medium
redirect: https://medium.com/@username/your-article-url
tags: [AI, Machine Learning]
categories: [Technical]
author: Narasimha Karthik J
---

Brief description or excerpt from your article...

[Read the full article on Medium](https://medium.com/@username/your-article-url){:target="_blank"}
```

## Method 3: Configuration with Individual URLs

If RSS feeds don't work, add individual posts in `_config.yml`:

```yaml
external_sources:
  - name: External Posts
    posts:
      - url: https://medium.com/@your-username/article-1
        published_date: 2024-01-15
      - url: https://your-pub.substack.com/p/post-1
        published_date: 2024-02-20
```

## How It Works

1. **RSS Feed Method**: The `external-posts.rb` plugin fetches posts from RSS feeds during site build
2. **Manual Method**: Creates markdown files that redirect to external URLs
3. **Display**: Posts appear in your blog listing with:
   - External source badges (Medium/Substack)
   - Read time estimates
   - Direct links to original articles
   - Option to show preview content

## Customization

### Styling
External posts have custom styling defined in `_sass/_base.scss`:
- `.external-source-badge`: Badge styling on blog listing
- `.external-post-notice`: Notice box on individual post pages

### Layout
The `_layouts/external-post.liquid` template controls how external posts are displayed.

## Troubleshooting

1. **Posts not showing up?**
   - Check if RSS URLs are correct
   - Run `bundle exec jekyll clean` then rebuild
   - Verify the external_sources configuration in _config.yml

2. **RSS feed errors?**
   - Some Medium/Substack accounts may have restricted RSS
   - Use Method 2 (Manual) instead

3. **Styling issues?**
   - Clear browser cache
   - Run `bundle exec jekyll build --verbose` to see any SASS errors

## Tips

- Keep descriptions concise (under 160 characters)
- Use consistent tags across internal and external posts
- Update regularly if using manual method
- Consider setting up GitHub Actions to auto-rebuild when adding posts

## Support

For issues specific to the external posts plugin, check:
- Plugin file: `_plugins/external-posts.rb`
- Layout: `_layouts/external-post.liquid`
- Styles: `_sass/_base.scss` (search for "external")