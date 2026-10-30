---
title: "LockIn: Browser Focus Tracker"
description: "Chrome extension and FastAPI backend that classifies page visits against your work goal, nudges you back, and reports on the session"
summary: "Chrome extension that labels each page visit on-task or distraction against your stated goal, stores sessions in Neo4j, nudges you, and writes a focus report."
date: 2026-04-02
weight: 18
tags: ["LLM Apps", "Neo4j", "FastAPI", "Chrome Extension", "Python"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/lockin)

## What it is

You start a session with a goal, such as "fix auth bug in login flow". The extension records each page you open. An LLM labels each visit on-task, distraction or ambiguous relative to that goal. If you drift, an overlay nudges you and offers to take you back. When the session ends you get a focus report.

![Focus report dashboard](https://raw.githubusercontent.com/JNK234/lockin/main/docs/images/report-dashboard.png)

## How it works

- **Extension (Manifest V3).** Sends each page load, with its URL, title and page text, to the backend, and polls a nudge endpoint every 60 seconds.
- **Backend (FastAPI).** Stores the visit and returns at once. Classification runs as a background task, so browsing never waits on the model.
- **Classification.** A RocketRide pipeline sends GPT-4o the goal, URL, title and the first 2,000 characters of the page, and asks for a JSON label and reason.
- **Graph storage (Neo4j).** Sessions, tasks, visits, sites and nudges are nodes. Visits link in order with `NEXT` edges, and sites link to tasks as `ON_TASK_FOR` or `DISTRACTION_FROM`.
- **Report and Q&A.** The report shows a focus score, a color-coded timeline, a per-site breakdown and LLM insights. A second pipeline answers plain-language questions about past sessions by querying the graph.

Neo4j runs in Docker Compose, and a seed script loads a demo session.
