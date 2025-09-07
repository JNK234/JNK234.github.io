#!/bin/bash

# Blog Post Creator for Jekyll al-folio theme
# Usage: ./new-post.sh "Your Post Title"

set -e

# Check if title is provided
if [ -z "$1" ]; then
    echo "Usage: ./new-post.sh \"Your Post Title\""
    echo "Example: ./new-post.sh \"Getting Started with Machine Learning\""
    exit 1
fi

# Get title from first argument
TITLE="$1"

# Generate slug from title (lowercase, replace spaces with hyphens, remove special chars)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 -]//g' | sed 's/ \+/-/g' | sed 's/^-\+\|-\+$//g')

# Get current date
DATE=$(date '+%Y-%m-%d')
DATETIME=$(date '+%Y-%m-%d %H:%M:%S%z')

# Format timezone properly (add colon)
DATETIME=$(echo "$DATETIME" | sed 's/\([+-][0-9][0-9]\)\([0-9][0-9]\)$/\1:\2/')

# Create filename
FILENAME="${DATE}-${SLUG}.md"
FILEPATH="_posts/$FILENAME"

# Check if file already exists
if [ -f "$FILEPATH" ]; then
    echo "Error: File $FILEPATH already exists!"
    exit 1
fi

# Create _posts directory if it doesn't exist
mkdir -p _posts

# Create the blog post file
cat > "$FILEPATH" << EOF
---
layout: post
title: "$TITLE"
date: $DATETIME
description: "Brief description of your post (update this)"
tags: []
categories: [technical]
giscus_comments: true
related_posts: false
featured: false
---

## Introduction

Write your introduction here. Hook your readers and explain what they'll learn.

## Main Content

### Section 1

Your content here. You can include:

**Code blocks:**
\`\`\`python
def example():
    return "Hello, world!"
\`\`\`

**Lists:**
- Point 1
- Point 2
- Point 3

**Links:** [Link text](https://example.com)

**Images:**
![Alt text]({{ '/assets/img/your-image.jpg' | relative_url }})

### Section 2

More content sections as needed.

## Conclusion

Wrap up with key takeaways.

---

*Next steps: Update the description and tags in the front matter above*
EOF

echo "✅ Created: $FILEPATH"
echo "📝 Title: $TITLE"
echo "📅 Date: $DATE"
echo ""
echo "Ready to write! Edit the file and:"
echo "1. Update description and tags in front matter"
echo "2. Replace template content with your post"
echo "3. Test locally: bundle exec jekyll serve"
echo "4. Commit and push to publish"

# Try to open the file in default editor (optional)
if command -v code >/dev/null 2>&1; then
    code "$FILEPATH"
elif command -v vim >/dev/null 2>&1; then
    vim "$FILEPATH"
elif command -v nano >/dev/null 2>&1; then
    nano "$FILEPATH"
else
    echo "💡 Open $FILEPATH in your editor to start writing"
fi
EOF