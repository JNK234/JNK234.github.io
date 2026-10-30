---
title: "Sycophancy Recovery Study"
description: "Five alignment methods against induced sycophancy in Qwen3-8B, judged behaviorally and probed mechanistically"
summary: "Induced sycophancy in Qwen3-8B, then compared DPO, SimPO, IPO, GRPO and Constitutional AI. DPO fooled the judge while a probe still found the disposition; CAI preference pairs did best."
date: 2026-05-28
tags: ["Post-Training", "Alignment", "Interpretability", "DPO", "GRPO", "Evals"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/sycophancy-recovery-study)

## Question

If you train a bad behavior into a model and then train it out, is it gone, or just hidden from the outputs?

## Setup

I induced sycophancy in Qwen3-8B with LoRA SFT, then tried five ways to remove it: DPO, SimPO, IPO, GRPO and Constitutional AI. A Qwen2.5-72B judge scored behavior over 20,656 prompts. Linear probes and relearning speed measured what changed inside the model.

## Findings

- **DPO hid it.** DPO scored 0.268 against 0.256 for the untouched base, so it looked fixed. But a probe trained on the sycophantic model still read the DPO model at 0.677 AUROC, and the DPO model relearned sycophancy in 5 gradient steps where the base needed 50+. Correlational: no activation patching yet.
- **Constitutional AI won.** With the same DPO trainer and only the labels swapped for critic-revised pairs, sycophancy dropped to 0.166, the best in the study.
- **GRPO's reward design mattered.** A binary reward left half the groups with no signal. A scalar reward model reached 0.169, at a cost in plain accuracy.

## Write-ups

1. [I Trained an AI to Be Sycophantic. Then I Tried to Fix It.](/posts/sycophancy-recovery-dpo/)
2. [DPO Hides Sycophancy. SimPO Reorganizes It.](/posts/sycophancy-recovery-simpo/)
3. [Deeper Alignment Made a Worse Model](/posts/sycophancy-recovery-ipo/)
4. [GRPO Beat Every Other Alignment Method](/posts/sycophancy-recovery-grpo/)
5. [Constitutional AI Beat Every Method I'd Tried](/posts/sycophancy-recovery-cai/)
6. [My Best Alignment Fix Sharpened the Direction](/posts/sycophancy-recovery-cai-probing/)
