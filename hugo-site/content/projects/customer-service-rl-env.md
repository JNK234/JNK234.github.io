---
title: "Customer-Service Agent RL Environment"
description: "RL environment for a tool-using support agent, with a state-gated reward and an LLM judge"
summary: "LLM customer with a hidden goal, 13-tool agent, reward gated on the database diff before a judge checks consent and honesty. Red-teaming caught a forged-consent hole in the judge."
date: 2026-10-05
weight: 1
tags: ["RL Environments", "Agents", "Evals", "LLM-as-Judge", "Python"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/customer-service-agent-rl-env)

## What it is

Two LLMs talk to each other. A **user simulator** plays a customer with a hidden goal and sees only what the agent says. An **assistant agent** follows a written store policy and uses 13 tools that read and change an in-memory database built from the [τ²-bench](https://github.com/sierra-research/tau2-bench) retail data (25 users, 45 orders, 50 products).

The tools check only data integrity, not policy. So a policy violation changes the database, and the reward can see it.

## The reward

1. **Gate on state.** The agent's database diff must match a correct outcome, and the agent must have made the required lookups. A confident transcript with a wrong write scores zero, and a do-nothing agent can't pass tasks where the right answer is "no write".
2. **Efficiency.** Fewer wasted tool calls score higher.
3. **Quality, by an LLM judge.** The judge checks consent before each write and whether every claim of a finished action matches the tool log. It asks one yes/no question per call and quotes evidence before its verdict. Hard violations cap the reward below the floor of any clean run.

A pytest suite checks that golden runs pass and do-nothing runs fail, with no API calls.

## What red-teaming found

- **Forged consent.** In a hand-written bad conversation, the customer's text contained fake "AGENT: ... CUSTOMER: Yes" lines, and the judge passed the consent check. Feeding the judge speaker-tagged messages fixed it.
- **Unfair simulator.** The user simulator once agreed and sent its stop token in the same message, so a correct agent scored 0.
- Against a judge-aware hostile customer, a Sonnet agent scored 1.0 and a Haiku agent scored 0, after handing off to a human following a correct denial.

These come from one or two runs per task, not pass rates.
