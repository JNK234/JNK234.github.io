---
layout: post
title: Example Jupyter Notebook Post - ML Model Training
date: 2025-01-20 10:00:00-0400
description: Demonstrating how to embed Jupyter notebooks in blog posts
tags: [jupyter, machine-learning, tutorial]
categories: [technical]
giscus_comments: true
related_posts: false
toc:
  sidebar: left
---

This post demonstrates how to embed Jupyter notebooks directly into your blog posts. Perfect for sharing ML experiments, data analysis, and technical tutorials with executable code!

## Embedding a Jupyter Notebook

Below is an example Jupyter notebook embedded directly in this post:

{::nomarkdown}
{% assign jupyter_path = 'assets/jupyter/ml-example.ipynb' | relative_url %}
{% capture notebook_exists %}{% file_exists assets/jupyter/ml-example.ipynb %}{% endcapture %}
{% if notebook_exists == 'true' %}
  {% jupyter_notebook jupyter_path %}
{% else %}
  <p>Note: Create your notebook at assets/jupyter/ml-example.ipynb to see it rendered here.</p>
{% endif %}
{:/nomarkdown}

## Benefits of Notebook Blog Posts

Using Jupyter notebooks in your blog posts allows you to:

1. **Show code and results together** - Readers see both input and output
2. **Include visualizations** - Plots and charts render beautifully
3. **Maintain reproducibility** - Share the exact notebook you used
4. **Support both themes** - Notebooks adapt to light/dark mode

## How to Add Your Own Notebooks

1. Create your notebook in Jupyter/Google Colab
2. Save it to `assets/jupyter/your-notebook.ipynb`
3. Reference it in your blog post using the embedding code
4. Build and preview your site

For detailed instructions, see the README in the `_posts` folder.

---

*This is an example post. Replace it with your own notebook-based content!*