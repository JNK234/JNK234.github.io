# Blog Posts Guide

This folder contains all your blog posts. The demo posts have been moved to `_posts_archive/demo_posts/`.

## How to Add a New Blog Post

### Method 1: Write a New Post (Your Own Content)

1. **Copy the template**:
   ```bash
   cp TEMPLATE-your-post-title.md YYYY-MM-DD-your-actual-title.md
   ```
   Example: `2025-02-01-understanding-llms.md`

2. **Edit the front matter**:
   ```yaml
   ---
   layout: post
   title: Understanding Large Language Models
   date: 2025-02-01 10:00:00-0400
   description: Deep dive into how LLMs work
   tags: [LLMs, NLP, deep-learning]
   categories: [technical]
   featured: true  # Set to true to feature on homepage
   ---
   ```

3. **Write your content** using Markdown

4. **Add images** (optional):
   - Place images in `/assets/img/`
   - Reference them: `![Description](/assets/img/your-image.jpg)`

### Method 2: Add External Posts (Medium/Substack)

#### Option A: Automatic RSS Import
Already configured in `_config.yml`:
- Medium: Uses your RSS feed
- Substack: Uses NeuraForge RSS feed

These will auto-import when you build the site.

#### Option B: Manually Add External Post
Create a file like this:

```markdown
---
layout: external-post
title: "My Medium Article Title"
date: 2025-01-20 00:00:00-0400
description: "Brief description"
external_source: Medium
redirect: https://medium.com/@narasimhakarthik/article-url
tags: [AI, machine-learning]
categories: [external]
---

Brief excerpt or description...

[Read on Medium](https://medium.com/@narasimhakarthik/article-url)
```

#### Option C: Use the Helper Script
```bash
ruby _scripts/add-external-post.rb
```
Follow the prompts to add external posts interactively.

### Method 3: Add Jupyter Notebook Posts

Turn your data science notebooks into blog posts! The al-folio theme supports embedding Jupyter notebooks directly.

#### Step 1: Prepare Your Notebook

1. **Create your notebook** in Jupyter, Google Colab, or VS Code
2. **Clean up your notebook**:
   - Remove debug/test cells
   - Add markdown explanations between code cells
   - Ensure outputs are visible (plots, results, etc.)
   - Clear any sensitive information

#### Step 2: Save to Assets

Save your notebook to:
```
assets/jupyter/your-notebook-name.ipynb
```

Example: `assets/jupyter/ml-model-training.ipynb`

#### Step 3: Create Blog Post

Create a new blog post file:
```markdown
---
layout: post
title: "ML Model Training with PyTorch"
date: 2025-02-01 10:00:00-0400
description: "Step-by-step guide to training ML models"
tags: [jupyter, machine-learning, pytorch, tutorial]
categories: [technical]
giscus_comments: true
related_posts: false
toc:
  sidebar: left
---

Brief introduction to your notebook content...

## Jupyter Notebook

{::nomarkdown}
{% assign jupyter_path = 'assets/jupyter/ml-model-training.ipynb' | relative_url %}
{% capture notebook_exists %}{% file_exists assets/jupyter/ml-model-training.ipynb %}{% endcapture %}
{% if notebook_exists == 'true' %}
  {% jupyter_notebook jupyter_path %}
{% else %}
  <p>Notebook not found. Please check the file path.</p>
{% endif %}
{:/nomarkdown}

## Key Takeaways

Summary of your findings...
```

#### Step 4: Test and Preview

```bash
bundle exec jekyll serve
```

Your notebook will be converted to HTML and embedded in the post!

#### Jupyter Notebook Tips

1. **Notebook Structure**:
   - Start with markdown cell explaining the goal
   - Break code into logical sections
   - Add explanatory markdown between complex code blocks
   - End with conclusions/takeaways

2. **Best Practices**:
   - Use descriptive variable names
   - Add comments to complex code
   - Include plots and visualizations
   - Show intermediate results
   - Clear outputs before saving (optional - depends on content)

3. **Common File Names**:
   - `ml-model-training.ipynb`
   - `data-analysis-netflix.ipynb`
   - `nlp-sentiment-analysis.ipynb`
   - `reinforcement-learning-demo.ipynb`

4. **Supported Content**:
   - Python code and outputs
   - Matplotlib/Seaborn plots
   - Pandas DataFrames
   - Mathematical equations (LaTeX)
   - Markdown explanations
   - Images and charts

5. **Theme Support**:
   - Notebooks automatically adapt to light/dark theme
   - Code syntax highlighting included
   - Mobile-responsive layout

## File Naming Convention

Always use this format: `YYYY-MM-DD-title-with-dashes.md`

Examples:
- `2025-01-15-welcome-to-neuraforge.md`
- `2025-02-01-implementing-rag-systems.md`
- `2025-03-10-lessons-from-boeing.md`

## Front Matter Options

```yaml
---
# Required
layout: post
title: Your Title
date: YYYY-MM-DD HH:MM:SS-0400

# Recommended
description: Brief description for listings
tags: [tag1, tag2, tag3]
categories: [category]

# Optional
featured: true/false          # Feature on homepage
giscus_comments: true/false   # Enable comments
related_posts: true/false      # Show related posts
toc:
  sidebar: left/right          # Table of contents
thumbnail: assets/img/thumb.jpg # Thumbnail image
author: Your Name              # Override default author

# For external posts only
external_source: Medium/Substack
redirect: https://external-url.com
---
```

## Categories Suggestions

- `technical` - Technical tutorials and guides
- `research` - Research findings and papers
- `personal` - Personal thoughts and experiences
- `tutorial` - How-to guides
- `external` - External published articles

## Tags Suggestions

- AI/ML: `machine-learning`, `deep-learning`, `NLP`, `LLMs`, `reinforcement-learning`
- Technical: `python`, `pytorch`, `tensorflow`, `coding`, `algorithms`
- Specific: `GPT`, `Claude`, `RAG`, `fine-tuning`, `transformers`
- Industry: `Boeing`, `Northwestern`, `research`, `industry`

## Preview Your Posts

Before publishing:
```bash
bundle exec jekyll serve
```
Visit: http://localhost:4000/blog/

## Tips

1. **Keep titles concise** but descriptive
2. **Use tags consistently** for better organization
3. **Add descriptions** - they appear in blog listings
4. **Feature important posts** with `featured: true`
5. **Use categories** to group related content
6. **Include code examples** when relevant
7. **Add images** to make posts more engaging

## Archive

All original demo posts are preserved in `_posts_archive/demo_posts/` for reference.