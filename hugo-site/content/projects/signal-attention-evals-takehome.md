---
title: "Spec-Conformance Evals for an Account-Risk Attention Agent"
description: "An evaluator that audits 629 agent dossiers against a formal spec, corrects the telemetry first, and tests which violations predict harm"
summary: "Evaluator for an account-risk agent: 29 spec rules checked against corrected telemetry and source text. 259 of 629 numeric claims failed to reproduce."
date: 2026-09-13
weight: 4
tags: ["Evals", "Agents", "Data Quality", "Statistics", "Python"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/signal-attention-evals-takehome)

## What it is

An AI-engineer assessment from Signal Labs. A fictional company runs an agent that watches 180 customer accounts and decides which risk signals a human should see. The agent's behavior is defined in a formal spec as a state machine with invariants, timing targets, policy rules and grounding rules. The data is 629 agent dossiers, 32,032 days of telemetry, 3,810 text artefacts, renewal outcomes, and labels from three annotators who disagree.

I built a `SignalEvaluator` that scores each dossier for quality, risk, whether it deserved attention, and the specific spec rules it broke. On top of it I wrote a violation report, an attention-budget analysis and a writeup.

## How it works

- **Spec to rules.** I transcribed the spec into a table of 29 rules, each with its spec identifier, section, severity class and owning check. Tests parse the LaTeX source of the spec and fail if a rule cites a section that does not exist.
- **Correct the data first.** The evaluator rebuilds telemetry before checking any claim: later backfill rows win over duplicates, a legacy collector's double-counted API calls are halved, and a latency scale change is undone. Inspection found three more distortions the docs did not list, including zero rows that were collector outages, not dead accounts. Where the data is missing, the check refuses rather than scoring zero.
- **Source-anchored checks.** Each numeric claim is recomputed from corrected telemetry. Each quoted piece of evidence is checked to exist, belong to the same account, and match verbatim. Text is read by rules plus a small local NLI model, with no external API calls inside `evaluate()`.
- **Tests.** A pytest suite includes 25 hand-derived golden dossiers.

## Results

- 259 of 629 dossiers state a percentage change that does not reproduce on corrected telemetry. In 58 of them the pipeline manufactured the decline; in 121 a real decline was overstated.
- Only one rule separated complaints: customer-visible plays on legal-hold or M&A-quiet-period accounts drew complaints at 32% (10 of 31), against 3% for the rest. No rule separated wasted escalations.
- On quality scores, the evaluator agreed with each annotator about as well as the annotators agreed with each other (Spearman 0.36 to 0.55, against 0.31 to 0.45 between humans). On "deserved attention" it fell below the human band.
- A spec-anchored routing policy under a 5-signals-per-owner-week cap routed 189 signals against the agent's 294. Its routed signals churned more often (39% against 30%), but it missed 16 accounts with $3.02M of realised loss.
- Bursts in signal volume traced to a collector migration, a regional ingest gap, and four public holidays.
