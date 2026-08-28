# F1 — Code You Can Write

> **Months 1–3 · ~110 hrs · the hardest and most important part of this track**
> **Exit signal:** three working tools you wrote from a blank file, public, with READMEs and tests.
> **The gap this closes:** you can read code. Everything downstream — Terraform, pipelines, automation, tooling — requires you to *write* it.

---

## 🧠 The one rule

> **No copy-paste. Type everything.**

You already read code well enough to follow along, which is exactly why this is dangerous: following along *feels* like learning and is not. The gap between reading and writing closes only through the physical act of producing code from a blank file, getting it wrong, and fixing it.

Every lab below assumes you type it. When you look something up — and you will, constantly, forever, that is the job — read it, close the tab, then type it from memory.

---

## 🗓️ Month 1 — Python that runs

### Concepts
- [ ] Values and types — `str`, `int`, `float`, `bool`, `None`, and why `"5" + 5` fails
- [ ] Collections — `list`, `dict`, `set`, `tuple`, and when each is the right shape
- [ ] Control flow — `if`/`elif`/`else`, `for`, `while`, `break`/`continue`
- [ ] **Functions** — arguments, defaults, return values, and why a function that does one thing is easier to fix
- [ ] Errors — `try`/`except`, reading a traceback **from the bottom up** (the last line is the actual error)
- [ ] Files — reading, writing, context managers (`with open(...)`)
- [ ] **Virtualenvs** — `python3 -m venv .venv`, `source .venv/bin/activate`, `pip install -r requirements.txt`. Do this from day one; never `pip install` globally
- [ ] Modules and imports — how a project is split across files

### Hands-on
- [ ] Work through *Automate the Boring Stuff* chapters 1–9, **typing every example**
- [ ] Solve 20 small exercises (Exercism's Python track is free and gives you mentor feedback)
- [ ] Write a script that reads a text file of IP addresses and prints only the private ones
- [ ] Deliberately cause five different errors — `NameError`, `TypeError`, `KeyError`, `IndexError`, `AttributeError` — and read each traceback until you can predict what it means

> 🎯 **Month-1 rep (ship it):** a script that takes a CSV of vulnerability findings and prints a count by severity. Public repo, README explaining how to run it. It is small. Ship it anyway.

---

## 🗓️ Month 2 — Python that does real work

This is where it starts paying for itself at your day job.

### Concepts
- [ ] **`requests`** — GET/POST, headers, auth, status codes, `raise_for_status()`, pagination
- [ ] **JSON** — `json.loads`/`dumps`, navigating nested structures without guessing
- [ ] `argparse` — turning a script into a tool with real flags
- [ ] `logging` — why `print()` does not survive contact with production
- [ ] `subprocess` — running other tools safely (**never** `shell=True` with input you did not write)
- [ ] Environment variables and secrets — `os.environ`, `.env` files, and why credentials never go in the code
- [ ] `pytest` basics — a test file, an assertion, `pytest -v`
- [ ] Type hints — `def rank(findings: list[dict]) -> list[dict]:` — they make code readable months later

### Hands-on
- [ ] Call a public API with `requests` and pretty-print a field from the response
- [ ] Handle its failure modes: timeout, 404, 500, malformed JSON. **Handle them, do not crash**
- [ ] Add `argparse` so the tool takes `--severity high --output report.json`
- [ ] Write three `pytest` tests for it and make them pass
- [ ] Read [`api-track/fastapi-scaffold/`](../api-track/fastapi-scaffold/) line by line — you now know enough to follow real code

> 🎯 **Month-2 rep (ship it):** **the ASPM ranker.** Take the vulnerability prioritisation you currently do by hand at work and write the tool that does it: pull findings from a file or API, rank by your actual business-risk logic, output a sorted report.
>
> This is the single highest-value thing in F1. It is real, it is yours, it encodes judgement nobody else has, and it is a genuinely strong interview artifact — *"I automated my own manual process"* is a better story than any tutorial project. Sanitise the data before publishing.

---

## 🗓️ Month 3 — Bash, Git, and making it stick

### Bash
- [ ] Variables, quoting (and why `"$var"` beats `$var` — the bug that ruins scripts)
- [ ] Conditionals, loops, exit codes, `$?`
- [ ] **`set -euo pipefail`** — fail fast, on every script you write from now on
- [ ] Pipes and redirection, `grep`/`sed`/`awk`/`cut`/`sort`/`uniq` at a working level
- [ ] When to reach for Bash (glue, 20 lines) vs Python (logic, anything more)

### Git — properly, not just `add`/`commit`/`push`
- [ ] Branching and merging; what a merge conflict is and how to resolve one deliberately
- [ ] `git rebase` vs `git merge` — and why teams argue about it
- [ ] Reading history: `git log --oneline`, `git diff`, `git blame`, `git show`
- [ ] **Undoing things** — `git restore`, `git reset`, `git revert`, and which is safe on a shared branch
- [ ] `.gitignore`, and never committing a secret. Install `gitleaks` as a pre-commit hook **now**
- [ ] The PR workflow: small commits, a clear description, responding to review

### Hands-on
- [ ] Write a Bash script that backs up a directory, with error handling and a log
- [ ] Cause a merge conflict on purpose in a throwaway repo, then resolve it
- [ ] Recover a "lost" commit with `git reflog` — the trick that saves you one day
- [ ] Open a PR against your own repo, review it, merge it. Get used to the ritual

> 🎯 **Month-3 rep (ship it):** package the ASPM ranker properly — `--help` that explains itself, `requirements.txt`, passing tests, README with real usage examples, and a GitHub Actions workflow that runs the tests on every push. **That last step is your first pipeline**, and it makes [F4](f4-first-pipeline.md) far less intimidating.

---

## 🚫 What to skip

You do not need these yet, and chasing them will cost you months:

- Object-oriented design, classes, inheritance — you will absorb what you need later
- Async/`await`, decorators, generators, metaclasses
- Data science, pandas, notebooks
- Learning a second language. Python and enough Bash. That is it.
- LeetCode-style algorithm practice — irrelevant to the roles you are targeting

---

## 📄 Exit criteria

- [ ] **Three public repos**, each with a README, each solving something real
- [ ] You can open a blank file and write a working 50-line script without a tutorial
- [ ] You can read a traceback and fix the bug without searching for the whole error string
- [ ] You use a virtualenv automatically, without thinking about it
- [ ] `gitleaks` runs on every commit you make
- [ ] The ASPM ranker is genuinely useful to you at work

> 🎯 **What this proves in an interview:** that you build tools rather than only assess them. The ASPM ranker in particular reframes your entire profile — it says you understood a manual process deeply enough to automate it, which is exactly what a Cloud Security Engineer is hired to do.

---

## 📚 Resources

| Resource | Type | Priority |
|---|---|---|
| [*Automate the Boring Stuff*](https://automatetheboringstuff.com/) — Al Sweigart (free online) | Book | ⭐⭐⭐ |
| [Exercism — Python track](https://exercism.org/tracks/python) (free, mentored) | Practice | ⭐⭐⭐ |
| [*The Linux Command Line*](https://linuxcommand.org/tlcl.php) — Shotts (free PDF), ch. 24–36 for Bash | Book | ⭐⭐⭐ |
| [Julia Evans' zines](https://wizardzines.com/) — Git, Bash, debugging | Reference | ⭐⭐⭐ |
| [Learn Git Branching](https://learngitbranching.js.org/) (free, visual) | Interactive | ⭐⭐ |
| [Real Python](https://realpython.com/) — `requests`, `argparse`, `pytest` guides | Articles | ⭐⭐ |
| [pytest documentation](https://docs.pytest.org/) — getting started only | Docs | ⭐⭐ |

---

_← [Foundations](README.md) | [F2 — Systems you can operate →](f2-linux-containers.md)_
