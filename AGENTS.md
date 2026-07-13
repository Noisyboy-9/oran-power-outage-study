# Project Context for Codex Agents

## Project Purpose

This repository contains an IEEE-style LaTeX report for a Dependable
Networking course project.

Working title:

> Simulation-Based Evaluation of O-RAN Radio Unit Sleep Policies During Power
> Outages

The study is a comparative simulation evaluation of predefined O-RAN radio
unit (O-RU/RU) sleep policies during a power outage. The core dependable
networking concern is maintaining emergency connectivity while extending RU
battery lifetime.

The work should be framed as evaluation, comparison, measurement, and analysis.
Avoid claiming that the project proposes a novel scheduling algorithm unless
the user explicitly adds one later.

## Build and Repository Workflow

- Main LaTeX entry point: `main.tex`.
- Build command: `make`.
- Watch command: `make watch`.
- Clean auxiliary files: `make clean`.
- Remove generated build output: `make distclean`.
- Generated PDF: `build/main.pdf`.
- Generated build artifacts live under `build/` and are ignored by git.
- The project uses `latexmk` through `.latexmkrc`.
- The original IEEE template file is kept only as reference material.

The current document class is:

```tex
\documentclass[conference]{IEEEtran}
```

If the final target becomes an IEEE journal instead of a conference-style
course report, update this document class deliberately and check formatting.

Bibliography lines are currently commented in `main.tex` until the first real
citation is added. The local minimal TeX Live install has `ieeetr.bst`, but not
`IEEEtran.bst`. If `IEEEtran.bst` becomes available, prefer it for final IEEE
formatting.

## Current Source Structure

- `main.tex`: title, author block, abstract, keywords, section inputs, and
  bibliography hook.
- `references.bib`: BibTeX references.
- `figures/`: figures and plots.
- `tables/`: table sources if needed.
- `sections/01_introduction.tex`
- `sections/02_background_related_work.tex`
- `sections/03_system_model_policies.tex`
- `sections/04_simulation_methodology.tex`
- `sections/05_discussion.tex`
- `sections/06_conclusion.tex`

Section filenames should keep numeric prefixes matching the report order.

## Required Report Structure

The report should remain a minimal six-section conference-style paper:

1. Introduction
2. Background and Related Work
3. System Model and Evaluated Policies
4. Simulation Methodology
5. Discussion
6. Conclusion
7. References

The user's latest preference changed Section 5 from "Results and Discussion" to
"Discussion". Keep the file and heading as `05_discussion.tex` and
`\section{Discussion}` unless the user asks otherwise.

## Abstract Expectations

Write the abstract last, around 150--200 words. It should briefly state:

- The problem: maintaining emergency connectivity when O-RUs operate on
  batteries during a power outage.
- The method: comparative evaluation using a custom simulator.
- The evaluated policies.
- The metrics: emergency connectivity/QoS and RU battery lifetime.
- The most important quantitative findings.
- The overall conclusion.

Avoid background detail and citations in the abstract.

## Section Guidance

### 1. Introduction

Include motivation, outage scenario, research problem, research question, scope,
and a short list of contributions.

Motivation should explain why communication availability matters during
disasters, why grid outages threaten O-RUs, why keeping every RU active can
waste battery energy, and why sleep scheduling can extend operation while
possibly reducing connectivity.

Use a primary research question close to:

> How do different RU sleep policies affect emergency connectivity and RU
> battery lifetime in an O-RAN network during a power outage?

Possible subquestions may cover battery threshold or sleep-cycle duration if
those parameters are actually evaluated.

Contributions should be modest:

- Develop a simplified simulation model of an O-RAN network under a power
  outage.
- Implement and compare predefined RU operating policies.
- Measure effects on emergency connectivity and battery lifetime.
- Analyse conditions under which each policy performs well or poorly.

### 2. Background and Related Work

Keep the section focused on concepts needed to understand the model.

Cover:

- O-CU, O-DU, and O-RU roles.
- Assumption that O-CUs and O-DUs have backup power.
- O-RUs depend on limited battery capacity.
- Active and sleep RU operating states.
- Base-station/RU energy consumption.
- Base-station sleep strategies.
- Energy-aware RAN management.
- Cellular-network resilience during disasters.
- Simulation-based evaluation of O-RAN or cellular energy policies.

End with a modest gap, for example:

> Existing work studies energy-efficient base-station operation, but the
> interaction between predefined sleep policies, emergency connectivity, and
> battery lifetime under a network-wide outage requires further comparative
> evaluation.

### 3. System Model and Evaluated Policies

This section formally defines what is simulated.

Include:

- Geographical simulation area.
- Sets of users and RUs.
- RU and user placement.
- Bipartite user-RU relationship.
- Outage start and simulation horizon.
- Initial RU battery capacities.
- Active and sleep power consumption.
- User mobility, or the assumption of stationary users.
- A simple system diagram when available.

Connectivity and SINR model:

- Distance between each user and RU.
- Coverage-distance threshold.
- Signal, interference, and noise assumptions.
- SINR calculation.
- Minimum SINR required for service.
- A user is connected at time `t` only if at least one RU is active, within
  coverage range, and provides SINR above the threshold.

Battery model:

- Initial battery energy.
- Active-state energy consumption.
- Sleep-state energy consumption.
- Battery update at each timestep.
- RU depletion condition.
- Whether state switching has an energy or time cost.

Evaluated policies:

1. Always active: every non-depleted RU remains active.
2. Periodic staggered sleep: RU groups alternate between active and sleep states
   at fixed intervals.
3. Threshold-triggered staggered sleep: RUs remain active until battery reaches
   a specified threshold, after which staggered sleeping begins.

These policies are the independent variables of the comparative study.

### 4. Simulation Methodology

Explain how evidence is produced.

Simulator:

- Why a custom simulator is suitable.
- Its main components and timestep-based operation.
- What is simplified or abstracted.
- Programming language and important libraries.

Experimental configuration should include a parameter table with:

- Number of RUs and users.
- Simulation-area dimensions.
- Simulation duration and timestep.
- Active and sleep power consumption.
- Initial battery capacities.
- Coverage and SINR thresholds.
- Sleep-cycle duration.
- Battery threshold.
- Number of repetitions.
- Random seeds.

Metrics:

- Emergency connectivity/QoS: proportion of users satisfying the connectivity
  condition over time.
- RU battery lifetime: time until individual or average RU battery depletion.
- Network operational lifetime, if formally defined: time until emergency
  connectivity falls below an acceptable level.

Experimental design and validation:

- State fixed and varied parameters.
- State independent simulation runs.
- Explain aggregation.
- Report confidence intervals or standard deviations if available.
- Validate the custom simulator with sanity checks.

Useful validation checks:

- Higher battery capacity should not reduce lifetime.
- Sleep-state consumption should be lower than active-state consumption.
- Always-active should initially provide the highest possible coverage.
- Depleted RUs must not serve users.
- Identical seeds and parameters should reproduce identical results.

### 5. Discussion

Although the heading is "Discussion", this section should still present and
interpret the results. Organize around the research question rather than around
individual graphs.

Include:

- Baseline comparison of all policies in the main scenario.
- Emergency connectivity over time.
- Battery levels or surviving RUs over time.
- Average battery lifetime.
- Network operational lifetime if used.
- Sensitivity analysis for the most influential parameters.
- Interpretation of trade-offs.
- Limitations.
- A direct answer to the research question.

Sensitivity analysis may vary:

- RU density.
- User density.
- Sleep-cycle duration.
- Battery activation threshold.
- SINR threshold.
- Initial battery capacity.

Do not vary every simulator parameter unless there is a clear reason.

Interpretation should explain which policy preserves battery longest, which
policy maintains emergency connectivity best, whether battery gains cause
unacceptable connectivity loss, when staggered sleeping is beneficial, and why
the observed behavior occurs.

Limitations may include simplified propagation and interference models, assumed
battery/power values, absence of real O-RAN hardware measurements, simplified
traffic, simplified mobility, simplified RU state transitions, and limited
generalizability of the selected topology.

### 6. Conclusion

Answer the research question directly:

- What did the comparison show?
- Which policy performed best under which conditions?
- How large was the observed trade-off?
- What practical insight follows from the results?

End with a short future-work paragraph, such as validating against hardware
measurements or evaluating adaptive scheduling policies.

## Writing and Editing Preferences

- Keep the project simple and suitable for a course report.
- Preserve IEEE formatting; avoid unnecessary package additions.
- Prefer clear, defensible claims over inflated novelty.
- Use "RU" and "O-RU" consistently based on surrounding context.
- Use active academic verbs such as evaluate, compare, measure, and analyse.
- Avoid turning the methodology into extensive software documentation.
- Add citations for academic papers, standards, models, datasets, and software
  documentation once sources are selected.
- Place figures in `figures/` and table sources in `tables/`.
- Rebuild with `make` after structural LaTeX changes.

