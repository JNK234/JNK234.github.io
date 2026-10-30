---
title: "job-hunt-kit"
description: "A Claude Code plugin for resumes, applications and outreach, with checks that block invented claims"
summary: "Claude Code plugin for the job hunt: tailored LaTeX resumes, live ATS form schemas, and a judge that checks every claim against your own profile file."
date: 2026-10-28
weight: 10
tags: ["Claude Code", "Agents", "LLM-as-Judge", "Python", "Tooling"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/job-hunt-kit)

## What it is

A Claude Code plugin with nine skills that cover a job search from start to finish: set up a profile, build master resumes from job-description research, tailor a resume to one posting, draft application answers, find the right person on the team, and write outreach.

Everything lives in plain text and LaTeX files in a `job-hunt/` folder that you own. The kit drafts. It never sends an email or submits a form.

## How it works

- **One source of truth.** `profile.md` holds every fact about you. Resumes, answers and emails may only state what is in it.
- **Live form schemas.** `ats.py` reads the exact application form from the public Ashby, Greenhouse and Lever APIs, because the pages are rendered client-side and scraping returns only a title. It checks a posting is live by its presence on the job board, since Ashby returns HTTP 200 for any path. It flags field titles worth a human look: inverted sponsorship questions, export-control questions, and decoy prompts addressed to an LLM.
- **A cheap gate, then a judge.** `gate.py` is a deterministic check for stock phrases, compliance claims (HIPAA, SOC 2 and so on) that the profile never mentions, numbers absent from the profile, and leftover placeholders. `judge.py` then asks yes/no rubric questions about each email or answer, and returns a fix for every NO.
- **Claim checking per sentence.** The judge splits a draft into sentences and asks, for each one, whether its background facts are supported by the profile and resume text.
- **Resumable pipeline.** `pipeline.py` tracks roles through sourcing, verification and drafting so a long batch can stop and pick up again.

## What's notable

The claim-check threshold was set on planted true and false claims: false claims scored at most 0.21 and true ones at least 0.40, so the cutoff sits at 0.3. Each exemption in the deterministic gate is commented with the false positive that caused it.
