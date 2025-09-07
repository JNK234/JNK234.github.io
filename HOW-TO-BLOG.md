# How to Write and Publish Blog Posts

## Quick Start

1. **Copy the template:** Duplicate `_posts/TEMPLATE-blog-post.md`
2. **Rename it:** Use format `YYYY-MM-DD-your-post-title.md`
3. **Edit the content:** Update front matter and write your post
4. **Commit and push:** Your site will rebuild automatically on GitHub Pages

## Detailed Guide

### File Naming Convention
```
_posts/YYYY-MM-DD-your-post-title.md
```
Examples:
- `_posts/2025-01-15-my-first-ai-project.md`
- `_posts/2025-02-01-machine-learning-tutorial.md`

### Front Matter (Header Section)
Every blog post must start with YAML front matter between `---` lines:

```yaml
---
layout: post
title: Your Post Title
date: 2025-01-15 10:00:00-0400
description: Brief description for SEO
tags: [ai, machine-learning, tutorial]
categories: [technical]
giscus_comments: true
related_posts: false
featured: false
toc:
  sidebar: left  # Optional: remove if no table of contents needed
---
```

**Field Descriptions:**
- `layout`: Always use `post` for blog posts
- `title`: The title that appears on your blog and in search results
- `date`: Publication date and time (format: YYYY-MM-DD HH:MM:SS-TTTT)
- `description`: Short description for SEO and social media previews (160 chars max)
- `tags`: Array of keywords to help readers find related content
- `categories`: Organize posts by type (technical, personal, research, tutorial, etc.)
- `giscus_comments`: Enable/disable comments section
- `related_posts`: Show related posts at bottom (true/false)
- `featured`: Featured posts appear prominently on homepage (true/false)
- `toc`: Add table of contents sidebar (remove entire section if not needed)

### Writing Content

Use standard Markdown syntax:

#### Headers
```markdown
# H1 Header
## H2 Header
### H3 Header
```

#### Code Blocks
````markdown
```python
def hello_world():
    print("Hello, world!")
```
````

#### Images
```markdown
![Alt text]({{ '/assets/img/your-image.jpg' | relative_url }})
```
*Note: Place images in `assets/img/` directory*

#### Links
```markdown
[Link text](https://example.com)
[Internal link]({{ '/about/' | relative_url }})
```

#### Lists
```markdown
- Bullet point 1
- Bullet point 2

1. Numbered item 1
2. Numbered item 2
```

#### Emphasis
```markdown
**Bold text**
*Italic text*
`Inline code`
```

### Advanced Features

#### Jupyter Notebooks
To embed a Jupyter notebook:

1. Save your notebook to `assets/jupyter/notebook-name.ipynb`
2. Add this code to your blog post:

```liquid
{::nomarkdown}
{% assign jupyter_path = 'assets/jupyter/notebook-name.ipynb' | relative_url %}
{% capture notebook_exists %}{% file_exists assets/jupyter/notebook-name.ipynb %}{% endcapture %}
{% if notebook_exists == 'true' %}
  {% jupyter_notebook jupyter_path %}
{% else %}
  <p>Notebook not found: {{ jupyter_path }}</p>
{% endif %}
{:/nomarkdown}
```

#### Mathematics
Use LaTeX syntax with MathJax:

```markdown
Inline math: $E = mc^2$

Block math:
$$
\int_0^1 x^2 dx = \frac{1}{3}
$$
```

#### Citations
If you have publications in `_bibliography/papers.bib`:

```markdown
{% cite einstein1905 %}
```

### Testing Locally

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Start local server:**
   ```bash
   bundle exec jekyll serve
   ```

3. **View your site:** Open http://localhost:4000 in your browser

4. **Auto-reload:** The site will refresh automatically when you save changes

### Publishing Workflow

1. **Write your post** in `_posts/YYYY-MM-DD-title.md`
2. **Test locally** using `bundle exec jekyll serve`
3. **Commit your changes:**
   ```bash
   git add _posts/your-new-post.md
   git commit -m "Add new blog post: Your Title"
   ```
4. **Push to GitHub:**
   ```bash
   git push origin main
   ```
5. **Wait for deployment:** GitHub Pages will rebuild your site automatically (usually takes 1-2 minutes)

### Content Ideas

- **Technical tutorials:** Step-by-step guides with code examples
- **Project walkthroughs:** Show your work and lessons learned  
- **Research summaries:** Explain papers or findings in accessible language
- **Opinion pieces:** Share your perspective on industry trends
- **Tool reviews:** Evaluate frameworks, libraries, or services
- **Career insights:** Share professional experiences and advice

### Best Practices

- **Write compelling titles** that clearly describe your content
- **Use descriptive filenames** that match your title
- **Add relevant tags** to help readers discover your content  
- **Include a good description** for SEO and social media
- **Test locally first** before publishing
- **Use images sparingly** but effectively
- **Keep paragraphs short** for better readability
- **Link to sources** and give credit where due

### Troubleshooting

**Post not showing up?**
- Check file naming convention
- Ensure front matter is valid YAML
- Verify date is not in the future
- Check for syntax errors in Markdown

**Images not loading?**
- Ensure images are in `assets/img/` directory
- Use correct relative path syntax
- Check file names and extensions

**Build failing?**
- Check GitHub Actions tab for error details
- Validate YAML front matter syntax
- Test locally first