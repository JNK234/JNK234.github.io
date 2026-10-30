---
title: "Kyn: Multi-Agent Company Brain"
description: "Hackathon build: a supervisor agent that pulls code and company context, ships artifacts, and writes lessons back to memory"
summary: "Hackathon agent for incident response: a GPT-5.5 supervisor calls code, company, memory and action subagents, then opens a real PR, Gmail draft and Slack post."
date: 2026-05-09
weight: 11
tags: ["Agents", "Multi-Agent", "OpenAI Agents SDK", "FastAPI", "Hackathon"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/KYN) · [Live demo](https://kyn-xi.vercel.app/)

## What it is

A team build for the Nozomio Hackathon, Track 4 ("The Company Brain", on Nia and Hyperspell). You describe a work problem, such as "why are payments failing?", and a supervisor agent decides what context it needs, gathers it, acts, and records what it learned.

I built the agent and backend: the supervisor and subagents, the tools, the seed corpus, the FastAPI server, and the wiring of the run-view UI to the live event stream. A teammate built the design system and the static UI mockup.

## How it works

- **Supervisor plus four subagents as tools**, using the OpenAI Agents SDK. Code context searches an indexed repo through Nia. Company context searches Slack, email, Notion, contracts and tickets through Hyperspell. Memory recalls similar past problems early and writes lessons back before the run ends. Action produces outputs.
- **Playbooks by intent.** The supervisor classifies the problem as an incident, a question, or a briefing. Only incidents open a PR and send messages; questions get a cited answer and no actions.
- **Real actions.** For a code fix, the Action agent clones the target repo, runs Codex CLI with a small, size-capped instruction, commits, pushes, and opens a PR, then drafts a Gmail and posts to Slack. Evidence goes in the PR body, not the Codex prompt.
- **Seed corpus.** A fictional payments company with about six weeks of Slack, email, Notion, contract, PR and ticket data around one incident: a retry bug that amplifies a vendor's rate limit. An early support ticket hints at the problem, so the agent can connect it where the humans in the story did not.
- **Server.** FastAPI streams run events over SSE, saves each run to disk, and can replay past runs.

## What's notable

The repo includes artifacts from real runs: RCA skeletons, code-patch proposals and PR drafts for the rate-limit incident.
