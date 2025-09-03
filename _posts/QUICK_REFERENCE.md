# Quick Reference - Adding Blog Posts

## 🆕 Add Your Own Blog Post

1. **Create new file in `_posts/`**:
   ```
   2025-02-15-my-awesome-post.md
   ```

2. **Copy this front matter**:
   ```yaml
   ---
   layout: post
   title: My Awesome Post
   date: 2025-02-15 10:00:00-0400
   description: Brief description here
   tags: [AI, machine-learning]
   categories: [technical]
   ---
   
   Your content here...
   ```

3. **Save and preview**:
   ```bash
   bundle exec jekyll serve
   ```

## 📰 Add External Post (Medium/Substack)

### Already on Medium/Substack? 
Your posts auto-import via RSS (configured in `_config.yml`)

### Want to add specific post?
Create file: `2025-02-20-my-medium-post.md`
```yaml
---
layout: external-post
title: My Medium Article
date: 2025-02-20 00:00:00-0400
description: Article summary
external_source: Medium
redirect: https://medium.com/@narasimhakarthik/your-article
tags: [AI]
categories: [external]
---

Preview text...
```

## 📓 Add Jupyter Notebook Post

### Quick Steps:
1. Save notebook to `assets/jupyter/my-notebook.ipynb`
2. Create post: `2025-02-15-my-ml-project.md`
3. Use this template:

```yaml
---
layout: post
title: My ML Project
date: 2025-02-15 10:00:00-0400
description: ML model training tutorial
tags: [jupyter, machine-learning]
categories: [technical]
---

## Notebook

{::nomarkdown}
{% assign jupyter_path = 'assets/jupyter/my-notebook.ipynb' | relative_url %}
{% jupyter_notebook jupyter_path %}
{:/nomarkdown}
```

## 📁 File Structure

```
_posts/
├── README.md                    # This guide
├── QUICK_REFERENCE.md           # Quick reference
├── TEMPLATE-your-post-title.md  # Template to copy
├── 2025-01-15-example-first-post.md  # Example post
└── YOUR-NEW-POSTS.md            # Your posts go here!

_posts_archive/
└── demo_posts/                  # All demo posts (archived)
```

## 🏷️ Common Tags
- `machine-learning`, `LLMs`, `NLP`, `deep-learning`
- `python`, `pytorch`, `research`, `tutorial`

## 📂 Categories
- `technical`, `research`, `personal`, `tutorial`, `external`

---
💡 **Tip**: Copy the template file to start quickly!