---
layout: post
title: Your Blog Post Title Here
date: 2025-01-XX 10:00:00-0400  # Update with actual date
description: A brief description of your post for SEO and previews (160 chars max)
tags: [tag1, tag2, tag3]  # Add relevant tags
categories: [category]     # Choose: technical, personal, research, tutorial, etc.
giscus_comments: true     # Enable comments (set to false to disable)
related_posts: false      # Set to true to show related posts
featured: false           # Set to true to feature this post
toc:
  sidebar: left           # Optional: add table of contents (remove if not needed)
---

## Introduction

Write your introduction here. This is where you hook your readers and explain what they'll learn from this post.

## Main Content

### Subsection 1

Your content here. You can include:

- **Code blocks:**
```python
def example_function():
    return "Hello, world!"
```

- **Lists and bullet points**
- **Images:** `![Alt text]({{ '/assets/img/your-image.jpg' | relative_url }})`
- **Links:** [Link text](https://example.com)

### Subsection 2

More content here.

## Conclusion

Wrap up your post with key takeaways or next steps.

---

**Instructions for using this template:**

1. **Rename the file:** Change `TEMPLATE-blog-post.md` to `YYYY-MM-DD-your-post-title.md`
2. **Update the front matter:** Fill in all the fields in the header section
3. **Write your content:** Replace this template content with your actual post
4. **Test locally:** Run `bundle exec jekyll serve` to preview
5. **Publish:** Commit and push to GitHub - the site will rebuild automatically

**Front matter field explanations:**
- `date`: Use format YYYY-MM-DD HH:MM:SS-TTTT (timezone offset)
- `tags`: Help readers find related content
- `categories`: Organize your posts by type
- `featured`: Featured posts appear prominently on your homepage
- `toc`: Adds a table of contents sidebar (remove entire `toc:` section if not needed)