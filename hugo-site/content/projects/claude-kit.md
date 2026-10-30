---
title: "claude-kit"
description: "The Claude Code skills, commands, agents and workflows I use day to day, packaged as a plugin marketplace"
summary: "Six Claude Code plugin bundles (writing, research vault, explainer videos, NetLogo, dev tools, life) and seven multi-agent workflows, one-command install."
date: 2026-10-15
weight: 15
tags: ["Claude Code", "Agents", "Tooling", "Workflows"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/claude-kit)

## What it is

A plugin marketplace for Claude Code that bundles the skills, slash commands, agents and workflows I use every day. It has six bundles:

- **writing**: outreach email, LinkedIn and X posts, research blog posts.
- **research-vault**: decode papers into Obsidian notes, extract atomic zettels, build synthesis pages.
- **explainer-videos**: narrated Manim explainer videos from a spec.
- **netlogo**: build and review NetLogo models.
- **dev-tools**: GitHub operations, a timed take-home helper, planning and implementation commands, and coder and tester agents.
- **life**: Vedic astrology charts and PDF invoices.

## How it works

`install.sh` clones the repo, adds the marketplace, installs the chosen bundles, writes a small env file with the vault paths, and copies the workflows into `~/.claude/workflows/` with those paths filled in. It skips workflows that already exist unless you set `FORCE=1`.

The seven workflows coordinate several agents. For example, `feature-build` has a coder implement a task, an implementation-blind tester try to break it, and the coder repair the cited failures, for up to three rounds.

## What's notable

- **netlogo-review** checks a model in layers ordered by cost: style and config checks, then the headless NetLogo compiler as a blocking gate, then known `.nlogox` traps. An LLM judge is opt-in, and a live provider call is required when a change touches a provider. It ships with self-test fixtures.
- **making-explainer-videos** includes scripts that check every on-screen word traces back to the approved spec, and falls back to macOS `say` when no ElevenLabs key is set.
- The research-vault skills use [zettelkasten-auto](/projects/zettelkasten-automation/) for semantic search over notes.
