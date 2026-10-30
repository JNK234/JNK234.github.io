---
title: "whoblinked"
description: "Competitor-intelligence SaaS that watches competitors' catalogues for launches, discontinuations and price changes"
summary: "Co-founder and CTO. Multi-tenant SaaS that tracks competitors' launches, discontinuations and price changes, with LLM output checked against live search."
date: 2026-07-01
weight: 3
tags: ["SaaS", "Data Pipelines", "LLM Apps", "React", "Startup"]
showTableOfContents: true
---

[whoblinked.com](https://whoblinked.com)

## What it is

whoblinked watches your competitors' catalogues and tells you what they launched, discontinued and repriced. I co-founded it and have been CTO since July 2026. The code is private.

I built it end to end, from the data model and API contracts to the React product. It is multi-tenant.

## How it works

- **Extraction with fallbacks.** Each scan tries the store's API first, then structured markup on the page, then a headless browser.
- **Block detection.** A scan that was blocked or failed is recognised as such, so it never shows up as a change in a competitor's catalogue.
- **LLM features.** Competitor discovery, gap analysis and ownership research. Model output is checked against live search results before a user sees it.
- **Cost and release.** Every LLM call has its cost tracked, and an automated test-and-release pipeline gates deploys.
