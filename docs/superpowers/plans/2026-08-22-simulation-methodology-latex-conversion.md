# Simulation Methodology LaTeX Conversion Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert the supplied Simulation Methodology draft into a compiling IEEE-style LaTeX section without changing its paragraph prose.

**Architecture:** Keep the report content in `sections/04_simulation_methodology.tex`. Use `listings` for pseudocode, `table`/`tabular` for the baseline configuration, and standard `figure`/`graphicx` support for the architecture diagram. Render the existing SVG architecture diagram to PDF because the configured PDF LaTeX build does not natively include SVG files.

**Tech Stack:** LaTeX, IEEEtran, graphicx, listings, latexmk, rsvg-convert.

**Spec:** `/Users/sinashariati/.codex/attachments/578399ab-04a0-486d-ac84-c01b3625999c/pasted-text.txt`

## Global Constraints

- Preserve every supplied paragraph's wording; alter only typography, LaTeX syntax, and cross-reference mechanics.
- Use the existing IEEE conference document class.
- Keep all report figures under `report/figures/`.
- Use LaTeX labels and `\\ref` commands instead of hard-coded figure, table, section, and algorithm numbers.
- Ensure `make` completes without LaTeX errors.

---

### Task 1: Add rendering support for structured methodology elements

**Files:**
- Modify: `report/main.tex`
- Create: `report/figures/simulator-architecture.pdf`

**Interfaces:**
- Consumes: `report/figures/simulator-architecture.svg`
- Produces: `graphicx`-compatible PDF architecture asset and a `listings` configuration usable by the methodology section.

- [ ] **Step 1: Render the architecture SVG as a PDF asset**

Run:

```bash
rsvg-convert -f pdf -o report/figures/simulator-architecture.pdf report/figures/simulator-architecture.svg
```

- [ ] **Step 2: Add the `listings` package and pseudocode style to the report preamble**

Add this after the existing package imports in `report/main.tex`:

```tex
\usepackage{listings}
\lstdefinestyle{pseudocode}{
  basicstyle=\footnotesize\ttfamily,
  frame=single,
  breaklines=true,
  columns=fullflexible,
  keepspaces=true,
  showstringspaces=false
}
```

- [ ] **Step 3: Confirm the new PDF asset is readable**

Run:

```bash
pdfinfo report/figures/simulator-architecture.pdf
```

Expected: a valid one-page PDF description.

### Task 2: Convert the methodology draft to IEEE-style LaTeX

**Files:**
- Modify: `report/sections/04_simulation_methodology.tex`
- Modify: `report/sections/03_system_model_policies.tex`

**Interfaces:**
- Consumes: the supplied Markdown draft and the figure asset from Task 1.
- Produces: `sec:simulation-methodology`, `fig:simulator-architecture`, `tab:baseline-configuration`, and labelled pseudocode listings that compile with the report.

- [ ] **Step 1: Add a label to the existing system-model section**

Add `\label{sec:system-model}` directly after its `\section{...}` command so the converted methodology prose can use `Section~\ref{sec:system-model}`.

- [ ] **Step 2: Replace the placeholder methodology file with LaTeX equivalents of the supplied draft**

Convert headings to `\section` and `\subsection`, Markdown emphasis to LaTeX typography, inline symbols to math mode, the architecture image to a `figure`, the configuration matrix to a labelled `table`, and each pseudocode block to a labelled `lstlisting`.

- [ ] **Step 3: Preserve the supplied wording while correcting table-only labels**

Use `Active RU with two or more users battery consumption` for the table's repeated multi-user row, because it is the label implemented by the simulator configuration.

### Task 3: Build and inspect the generated report

**Files:**
- Verify: `report/build/main.pdf`

**Interfaces:**
- Consumes: the complete report source and generated PDF figure.
- Produces: build evidence that figures, tables, listings, and cross-references render successfully.

- [ ] **Step 1: Build the report**

Run:

```bash
make
```

Expected: `latexmk` exits successfully and writes `build/main.pdf`.

- [ ] **Step 2: Check for unresolved references and LaTeX errors**

Run:

```bash
rg -n "LaTeX Warning: Reference|Undefined control sequence|! " build/main.log
```

Expected: no output.

- [ ] **Step 3: Render the PDF for visual inspection**

Run:

```bash
pdftoppm -f 1 -l 10 -png -r 150 build/main.pdf /private/tmp/report-page
```

Expected: report page images suitable for checking layout and overflow.
