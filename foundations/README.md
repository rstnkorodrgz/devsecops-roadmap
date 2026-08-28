# 🔧 Foundations — The Conversion Track

> **This is not a beginner path.** It is a **conversion path**: from *reviewing* systems to *building* them.
> **Duration:** 9 months, then you join [Phase 1](../phases/phase-1-terraform.md) of the main ladder with the hands to actually do it.
> **Next job target:** Cloud Security Engineer — the shortest credible jump from where you stand.
> **Budget:** the same 8–10 hrs/week the rest of this roadmap assumes (~340 hrs total).

---

## 🎯 The honest diagnosis

You hold a **DevSecOps Lead** title and do **risk-analyst review** work — ASPM, prioritising live vulnerabilities by business risk, assessing other people's pipelines. You can read code. You cannot yet write it from scratch. You are not deploying.

That is a specific and very fixable position, and it is more common than anyone admits — especially in regulated markets where the security function grew out of governance rather than engineering. Naming it precisely matters, because it changes what you need:

| | |
|---|---|
| **What you are not missing** | DevSecOps concepts, security judgement, control frameworks, what "good" looks like, vocabulary, risk reasoning |
| **What you are missing** | Reps. The muscle of building, breaking, and operating a thing yourself |

The main roadmap ([README.md](../README.md)) assumes the second column already exists. That is why it does not work for you as written — not because it is too advanced conceptually, but because every phase asks you to *build* something and you have not yet built anything.

## 💪 The asset nobody will tell you about

**You can already tell good from bad.** That is the thing career-changers and bootcamp graduates spend years failing to acquire, and you got it from three years of reviewing other people's work.

When you finally build a pipeline, you will not build a naive one. You already know what an auditor will ask, where controls get faked, which findings are noise, and why a gate that blocks everything gets switched off within a month. **Almost nobody who is learning to build has that.**

So this track is short on theory and long on typing. The judgement is already there. Only the hands are missing.

## ⚠️ The risk you need to manage

Your title will get you interviews your hands cannot yet pass. That is a genuinely unpleasant experience and it is avoidable.

> **Sequencing rule: do not take a hands-on technical screen before you finish [F3](f3-azure.md).** Recruiter screens and architecture conversations, yes — you will do well in those. Live coding, a take-home, or "walk me through a pipeline you built," no. Not yet. Around month 8 that flips, and it flips hard.

## 🔁 The highest-leverage move available to you

**Every review you do at work is a build brief.**

You are handed real systems, with real controls, and asked to assess them. Nobody else learning to build gets that. Convert it:

- [ ] Reviewed a pipeline this week? **Build a minimal version of it** in your own repo this weekend
- [ ] Prioritised 30 vulnerabilities by business risk? **Write the script that pulls and ranks them** instead of doing it by hand
- [ ] Wrote a finding about a misconfiguration? **Write the Checkov or Inspec rule that detects it** automatically
- [ ] Asked a team for evidence of a control? **Produce that evidence for your own lab** first, so you know exactly what you are asking for

This is the difference between 9 months of study and 9 months of study that compounds with 40 hrs/week of exposure. Do not skip it — it is worth more than any course in this file.

---

## 🗺️ The track

```
F1  Code you can write        ──► Python & Bash, project-driven   months 1–3
F2  Systems you can operate   ──► Linux + Docker, hands-on         months 3–5
F3  Cloud you can build in    ──► Azure + AZ-104 ★ the pivot       months 5–8
F4  Your first pipeline       ──► build & deploy it yourself       months 8–9
─────────────────────────────────────────────────────────────────────────
    ↓ join the main ladder
Phase 1  Terraform Associate  ──► the existing roadmap, months 1–3 of it
```

| | Track | Months | Exit signal |
|---|---|---|---|
| **F1** | [Code you can write](f1-code.md) | 1–3 | Three working tools you wrote from a blank file |
| **F2** | [Systems you can operate](f2-linux-containers.md) | 3–5 | An app you containerised, deployed, broke, and fixed |
| **F3** | [Cloud you can build in](f3-azure.md) ★ | 5–8 | **AZ-104 passed** + an Azure environment you built |
| **F4** | [Your first pipeline](f4-first-pipeline.md) | 8–9 | A pipeline you built, not one you reviewed |

★ **F3 is the pivot.** AZ-104 is the credential that says you *operate* Azure rather than assess it, and it is the one that makes "Cloud Security Engineer" a credible application rather than an aspirational one.

## 🎓 Why AZ-104 and not something security-flavoured

Because the gap is not security knowledge. You have Security+, you have the Lead title, you review cloud security work daily. Adding another security certificate proves nothing you have not already proven.

AZ-104 proves the thing you cannot currently claim: **you can build and operate cloud infrastructure.** It is also the standard prerequisite expectation for Cloud Security Engineer roles in Azure-heavy markets, which the Chilean market is.

SC-500 stays where the main roadmap put it ([Phase 4](../phases/phase-4-sc500.md)) — it will be far easier after you have actually operated the platform.

> 💡 If AZ-104 material feels like a wall in the first fortnight, drop back to **AZ-900** for three weeks and return. That is a sequencing correction, not a failure.

---

## 📅 Where the job application actually happens

Not at the end. **Month 8–9**, right after AZ-104 lands and F4 gives you one real artifact.

| Month | Milestone | What you can honestly claim |
|---|---|---|
| 3 | F1 done | "I write Python tooling for security work" — with three repos to show |
| 5 | F2 done | "I containerise and operate services" |
| **8** | **AZ-104 passed** | **"I build and operate Azure infrastructure"** — start applying |
| 9 | F4 done | "Here is a secure pipeline I built end to end" — the portfolio piece |
| 12+ | Phase 1 (Terraform) | You are inside the main roadmap, ideally in the new job |

## 📏 The rule that matters most

**Ship something public every month, not every quarter.** The main roadmap's quarterly cadence is calibrated for a senior engineer who already has a body of work. You are building one from zero, and monthly reps beat quarterly polish at this stage.

They do not have to be impressive. A 40-line script with a README and a passing test is a rep. Twelve of those is a portfolio, and it is a far better signal than one large unfinished project.

- [ ] Track monthly artifacts in [`progress/quarterly-tracker.md`](../progress/quarterly-tracker.md) alongside the quarterly ones

## 🛠️ How to use this repo

### This repo tracks the plan. Your artifacts live elsewhere.

Do **not** build the ASPM ranker inside `devsecops-roadmap`. Each artifact gets its own public repo:

```
devsecops-roadmap     ← the plan + your progress (this repo)
aspm-ranker           ← F1 · the tool that ranks your findings
azure-baseline        ← F3 · the environment you build
secure-pipeline-lab   ← F4 · the pipeline with planted failures
```

A hiring manager opens your GitHub profile and sees a list of repos. Four focused repos with READMEs read as a practitioner. One monorepo called *"my-learning"* reads as a student. Same work, opposite signal — and you already know this instinctively from reviewing other people's evidence.

Month 1's small script can just be the first commit of `aspm-ranker`. Same lineage, no extra repo.

### Three tracking layers, one source of truth

| Layer | Role | Lives in |
|---|---|---|
| **Markdown checkboxes** | **Authoritative.** In git, diffable, survives browsers and laptops | This repo |
| [`progress/quarterly-tracker.md`](../progress/quarterly-tracker.md) | The accountability artifact — the monthly table + a 5-minute check-in at month end | This repo |
| [The dashboard](https://rstnkorodrgz.github.io/devsecops-roadmap/) | Motivation only. Saves to browser `localStorage` — **not synced, not in git** | Your browser |

The tracker is the one that keeps you honest, because it asks *"did you ship?"* rather than *"did you study?"*

### The daily loop

Edit locally, not in the GitHub web UI. Ticking a checkbox is the lowest-stakes possible Git rep, and [F1 month 3](f1-code.md) is literally *"learn Git properly"* — take the practice.

```bash
cd ~/Security_Research/devsecops-roadmap
git pull                                    # always first
# ... tick your boxes ...
git add -A
git commit -m "progress: F1 M1 — Python basics done"
git push
```

> ⚠️ **Pick one place to edit, not both.** Editing in the web UI *and* locally in the same week is how you get merge conflicts you do not yet know how to resolve.

Pages serves from the `version-2.3` branch, so every push updates the live dashboard within a minute or two. No merge to `main` required.

### Your first week

- [ ] Read this file end to end — especially [the highest-leverage move](#-the-highest-leverage-move-available-to-you)
- [ ] Open [`f1-code.md`](f1-code.md) and start Month 1. *Automate the Boring Stuff* ch. 1–2, **typed, not copy-pasted**
- [ ] Create the `aspm-ranker` repo — empty, with a README saying what it will do. Claiming the name makes it real
- [ ] Tick what you finish, commit, push. Even one box
- [ ] Put a calendar reminder at **month 6: book AZ-104**

---

## 🧯 What to do when it stalls

It will. Plan for it now rather than treating it as evidence you cannot do this.

- **"I read the docs but I cannot write it from scratch."** Normal, and the exact gap F1 is built to close. The fix is typing without copy-paste, not reading more.
- **"I do not have time this week."** Ship a 20-minute rep instead of nothing. Continuity beats volume.
- **"Everyone else seems to already know this."** They are reviewing what you are building. You have the harder half already.
- **Stuck for more than two evenings on the same thing?** Skip it, note it, move on, come back. Sequential blocking is the main way self-directed plans die.

---

_[Back to README](../README.md) | [F1 — Code you can write →](f1-code.md)_
