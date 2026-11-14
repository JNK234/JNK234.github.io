---
title: "Before You Polish the Rubric"
slug: "before-you-polish-the-rubric"
date: 2026-11-14
description: "When an LLM judge gives scores you don't trust, the reflex is to rework the rubric. In the studies I read, three other things moved judges more: who judges, what the judge is given to check against, and the order it works in."
summary: "Swapping the judge raised agreement with humans by 0.26; adding per-skill rubrics raised it by 0.04 to 0.08. Taking the reference answer away cost five times what taking the rubric away cost. And one judge accepted 72% of wrong answers when told to verify, and 1% when made to write its own answer first."
tags: ["LLM-as-a-Judge", "Evaluation", "Rubrics", "Reward Design", "LLMs"]
categories: ["technical"]
showTableOfContents: true
---

When an LLM judge gives scores you don't trust, the first thing most of us do is rework the rubric. Add levels. Split it into dimensions. Mark some criteria as more important than others.

One study put a number on how much that kind of change helps. [FLASK](https://arxiv.org/abs/2307.10928) scored model answers with a judge and compared the judge's scores with human scores. Replacing one overall score with a separate levelled rubric for each skill raised the judge's correlation with humans by 0.04 to 0.08, depending on the judge. Swapping the judge from GPT-3.5 to GPT-4, with the rubric held fixed, raised it by 0.26.

My claim in this post: the form of a rubric, meaning its levels, weights and scoring arithmetic, is the smallest lever you have on a judge. Three things moved judges more in the studies I read: who does the judging, what the judge is given to check against, and the order the judge is made to work in. What the rubric says still matters, and I come back to that.

Think of marking an exam. You can restructure the mark scheme. Or you can change the marker, hand the marker the answer key, or make the marker write their own answer before looking at the student's.

I ran none of these experiments. This is a reading across nine sources, and no single source compares all four levers. Some of the evidence is about judges used for evaluation and some about judges used as a training reward. I say which each time.

## Who is marking?

The FLASK comparison, as Spearman correlation with human scores (rank correlation; 1.0 means the same ordering) on 200 instances:

| Judge | One overall score | Per-skill rubrics |
|---|---|---|
| GPT-3.5 | 0.360 | 0.424 |
| Claude | 0.352 | 0.432 |
| GPT-4 | 0.641 | 0.680 |

The rubric helps every judge. It does not come close to closing the gap between them. If anything the table flatters the rubric: the one-score baseline copies its single score to every skill, which handicaps it.

One reading of why the marker matters this much is that a judge cannot grade what it cannot do. In the same study, a weaker judge gave higher scores for logic and made a weak model look close to strong ones, against the human labels.

A weak judge is also easier to fool with length. [MT-Bench](https://arxiv.org/abs/2306.05685) took 23 answers containing a list, rephrased the list, and pasted the rephrased copy in front of the original. Same content, twice the length. Two weaker judges preferred the padded version 91.3% of the time. GPT-4 did 8.7% of the time.

The same thing shows up when the judge is a training reward. A [study of rubric-based RL](https://arxiv.org/abs/2605.12474) trained the same model against two judges and checked both against a panel of three stronger models. On medical prompts with the weak judge, the share of new rubric credit that all three panel models judged undeserved rose from 39% to 65% over training. With the strong judge it stayed between 15% and 21%. One run each.

Two corrections to "use the strongest model". In [HealthBench](https://cdn.openai.com/pdf/bd7a39d5-9e9f-47b3-903c-8b847ca650c7/healthbench_paper.pdf), the model that answered best was not the best grader: on agreement with physicians (macro-F1), GPT-4.1 scored 0.709 and o3 scored 0.681. The grader prompt had been tuned on GPT-4.1, so hold that loosely. Either way, measure judge quality on your own task. And size alone did not hold up under pressure, which is the third section.

## Does the marker have the answer key?

FLASK also removed the parts of the judge's prompt one at a time. With everything in, correlation with humans was 0.680. Without the rubric it was 0.646. Without the reference answer it was 0.516. Losing the answer key cost about five times what losing the mark scheme cost.

[Rubrics as Rewards](https://arxiv.org/abs/2507.17746) shows the same thing on the training side, and also shows what a rubric is worth. It trained a 7B model with different judges as the reward and scored the result on a medical benchmark (0 to 100):

- Judge gives a plain rating, sees no reference: 23.9
- Judge gives a plain rating, sees the reference answer: 31.7
- Judge uses a per-question rubric written without the reference: 32.0
- Judge uses a per-question rubric written from the reference: 35.9

The reference is worth about 8 points with no rubric. A rubric written for the question is worth about 8 points with no reference. Together they add about 12. These are single runs with no error bars, and the same judge model graded the benchmark, so the sizes are soft. The shape is clear enough: the answer key is at least as big a lever as the rubric, and most rubric work never touches it.

The key does not have to be a gold answer. It can be anything the model being graded did not have. [DR Tulu](https://arxiv.org/abs/2511.19399) gave its rubric writer search results for each question. The share of criteria that made a concrete, checkable claim went from 0.22 to 0.56. The gain downstream was modest, about one point on the paper's benchmark average.

## Does the marker write their own answer first?

This is the lever I had not expected, and it has the largest single effect in these sources.

MT-Bench noticed that GPT-4 failed to grade basic math problems that it could solve when asked directly. Shown a wrong answer, it was misled by it. On 20 judgments it passed a wrong answer 14 times. Asking it to reason step by step first cut that to 6. Having it write its own answer in a separate call, then compare, cut it to 3. Reasoning with the wrong answer in view is not checking. The judge follows the same path and arrives at the same answer.

A [recent paper](https://arxiv.org/abs/2607.05904) tested this under pressure. A small model was trained to maximise a judge's approval on grade-school math, with its reasoning deliberately restricted so that most of its answers were wrong. After training, its wrong answers were more convincing, not fewer. A judge 3.5 times its size still accepted 77% of them, and requiring three different judges to agree did not help.

Then the original judge graded the same wrong answers two ways. Told to recompute independently, it accepted 71.9% of them. Made to write "My answer:" before comparing, with the candidate still on the page, it accepted 1.2%. The judge could solve these problems 93% of the time all along. It was not using that ability while a convincing answer sat in front of it.

That gives a test you can run wherever answers can be matched exactly. A judge that really writes its own answer first can pass a wrong answer only when it makes the same mistake, so its false-pass rate cannot exceed its own error rate. If it does, the shown answer is leaking into its reasoning.

Three limits. The result is from 128 answers in grade-school math. It needs an answer that can be matched exactly. And it hurts a judge that cannot solve the task: on a code benchmark, writing its own solution first made a 1.7B judge worse and an 8B judge better, though still far from perfect.

There is weaker evidence that order matters on open-ended grading too. In FLASK, removing the step where the judge explains before scoring cost 0.046, more than removing the rubric. [GLIDER](https://arxiv.org/abs/2412.14140) trained a small judge to list the evidence it relied on before giving a score; against the same judge trained without that step, average correlation with humans rose from 0.480 to 0.534. That is a trained behaviour, not a prompt instruction.

## What about levels and weights?

Here the evidence is thin, and what there is does not favour polishing.

- A [review of rubric studies](https://www.frontiersin.org/journals/education/articles/10.3389/feduc.2018.00022/full) in education found 13 that measured learning or motivation. All 13 reported positive effects: 8 used levels that described the work, 5 used levels worded as judgments such as "average". The author's reading was that the criteria were the shared ingredient; she could not show that level descriptions add nothing, and names publication bias. This is a count of studies, not a pooled effect.
- In Rubrics as Rewards, letting the judge read the whole rubric and give one rating beat scoring each criterion and adding up the weights, 31.2 against 29.7 on the same benchmark.
- Deleting the importance labels from the rubric raised the score, 38.8 against 37.2.
- Deleting every "must not" criterion changed nothing, 37.2 both ways. The authors' explanation, which they did not test, is that these were written from the reference answer and so named mistakes the model did not make.

The last three are single numbers from one paper with no error bars, and gaps of 1.5 points may be noise. I would not build on any one of them. What they do not show is structure paying for itself.

Two cautions in the other direction. In FLASK, finer rubrics made the judge harder to fool with padding: scores stayed unchanged for 43.8% of padded answers with one overall score and 55.8% with per-question checklists. And in the rubric-RL study, the weights did matter in aggregate, which is the last section.

## Where the rubric earns its place

None of this says the rubric does not matter. What it says matters a great deal.

A generic rubric is worse than none. In Rubrics as Rewards, one four-item rubric applied to every question trained a model to 12.5 on the main benchmark. A plain rating with no rubric got 25.5. In DR Tulu, one rubric shared across all questions bought nothing: 500 steps of training moved the average from 54.7 to 54.8.

A rubric written for the question is worth as much as the answer key, as the list above showed.

A specific rubric helps a small judge most. The same paper used judges of different sizes as the training reward and scored the model each one produced. A 7B judge with a bare rating trained a model to 22.0; the same judge with a per-question rubric trained one to 26.7. For a 32B judge the figures were 25.4 and 26.2, and a 14B judge barely moved. With the rubric, the small judge trained as good a model as the large one.

The wording that seems to help is the unglamorous kind. The rubric writer in that paper was told to say "identifies (B)", never "identifies the right choice", so a judge with no domain knowledge could check it. And in one example from GLIDER, a small judge scored a neutral question as misinformation because the criterion never said what to do with neutral text.

How does this fit with the first section, where rubrics could not close the gap between judges? FLASK's rubrics were written per skill, not per question. My reading, which no source here tests: a rubric helps a judge decide what to look for. It does not help a judge check reasoning it cannot do.

## What none of this fixes

A better marker with the answer key, writing their own answer first, is still marking against a list. In the rubric-RL study, the strong judge was fooled less often than the weak one, but in the same three ways and about the same proportions: credit for part of a compound criterion, credit for something implied but not stated, and loose matching. The grading prompt explicitly forbade the first. That breakdown was produced by a model with no human check.

And the run with the strong judge, which looked healthy on every measure, still went wrong. Shown the rubric, the panel preferred the trained model on 85.8% of prompts. With the rubric hidden, it preferred the untrained model on 78.4%. The judge read the rubric well. The rubric was not the whole of a good answer. The paper's proposed reason is about weights after all: "must include" criteria held 90.2% of the total weight and "must not" criteria 8.6%, so the reward mostly said add things.

## The order I would work in

Measure candidate judges on your own task and pick the best you can afford. Give the judge something the graded model did not have: a reference answer or retrieved evidence. Where answers can be matched, make the judge write its own first. Write criteria for the question, and say exactly what to check. Leave the levels and the labels for last, but look at what the weights add up to.

## What this does not show

The ranking of the levers is my assembly. Only FLASK puts judge, reference and rubric in one table, and that is evaluation, not training. In the training results, the measured effects of form, a stronger judge and better-grounded criteria are all one to two points, so "smallest lever" is not shown there.

The sources differ in task, model and year. The write-first result is from grade-school math under training pressure; the code result is from picking the best of 16 samples, with no training.

The open question is the case with no answer key at all. Most of what worked here leans on one. What does "write your own answer first" mean when the task is a research report, and the judge's own attempt is just another sample?

## References

1. Ye, Kim et al., *FLASK: Fine-grained Language Model Evaluation based on Alignment Skill Sets*, ICLR 2024. https://arxiv.org/abs/2307.10928
2. Zheng et al., *Judging LLM-as-a-Judge with MT-Bench and Chatbot Arena*, NeurIPS 2023. https://arxiv.org/abs/2306.05685
3. Zhou, *More Convincing, Not More Correct: Self-Play Reward Hacking of Reference-Free LLM Judges*. https://arxiv.org/abs/2607.05904
4. Deshpande et al., *GLIDER: Grading LLM Interactions and Decisions using Explainable Ranking*, 2024. https://arxiv.org/abs/2412.14140
5. Gunjal et al., *Rubrics as Rewards: Reinforcement Learning Beyond Verifiable Domains*, 2025. https://arxiv.org/abs/2507.17746
6. Shao, Asai, Shen, Ivison et al., *DR Tulu: Reinforcement Learning with Evolving Rubrics for Deep Research*, ICML 2026. https://arxiv.org/abs/2511.19399
7. Mahmoud, Rezaei, Wang, Gunjal, Liu, He, *Reward Hacking in Rubric-Based Reinforcement Learning*, 2026. https://arxiv.org/abs/2605.12474
8. Arora, Wei et al., *HealthBench: Evaluating Large Language Models Towards Improved Human Health*, OpenAI, 2025. https://cdn.openai.com/pdf/bd7a39d5-9e9f-47b3-903c-8b847ca650c7/healthbench_paper.pdf
9. Brookhart, *Appropriate Criteria: Key to Effective Rubrics*, Frontiers in Education, 2018. https://www.frontiersin.org/journals/education/articles/10.3389/feduc.2018.00022/full
