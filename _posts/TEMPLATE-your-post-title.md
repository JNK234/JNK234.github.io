---
layout: post
title: Your Post Title Here
date: 2025-01-01 00:00:00-0400
description: A brief description of your post (appears in blog listing)
tags: [machine-learning, LLMs, NLP]  # Add relevant tags
categories: [technical]  # Categories like: technical, tutorial, research, thoughts
giscus_comments: true  # Enable/disable comments
related_posts: true  # Show related posts at bottom
featured: false  # Set to true to feature this post
toc:
  sidebar: left  # Table of contents position (left, right, or remove for none)
---

## Introduction

Start your blog post here. You can use Markdown formatting for your content.

## Adding Code

```python
# Python code example
def hello_world():
    print("Hello from NeuraForge!")
```

## Adding Images

You can add images using:
```markdown
![Image description](/assets/img/your-image.jpg)
```

Or with more control:
```liquid
{% raw %}
{% include figure.liquid path="assets/img/your-image.jpg" title="image title" class="img-fluid rounded" %}
{% endraw %}
```

## Adding Math

You can use LaTeX for math equations:

Inline math: $$E = mc^2$$

Block math:
$$
\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}
$$

## Tips for Writing

1. Use descriptive titles
2. Keep paragraphs short and readable
3. Add code examples when relevant
4. Include images to break up text
5. Use headers to organize content
6. Add tags for discoverability

---

Remember to:
- Update the date to your publication date
- Change the filename to: YYYY-MM-DD-your-post-title.md
- Place images in /assets/img/ folder
- Preview locally with: bundle exec jekyll serve