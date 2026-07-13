# Dependable Networking Report

LaTeX project for the IEEE-style report:

**Simulation-Based Evaluation of O-RAN Radio Unit Sleep Policies During Power Outages**

## Structure

- `main.tex`: paper entry point.
- `sections/`: paper body split according to the report outline, with numeric
  filename prefixes matching the section order.
- `references.bib`: BibTeX references.
- `figures/`: figures and plots used by the paper.
- `tables/`: larger table sources, if needed.
- `build/`: generated LaTeX output.
- `conference_101719.tex`: original downloaded IEEE template, kept as a reference.
- `IEEEtran.cls`: IEEE class file supplied with the template.

## Draft Outline

1. Introduction
2. Background and Related Work
3. System Model and Evaluated Policies
4. Simulation Methodology
5. Discussion
6. Conclusion
7. References

## Build

Build once:

```sh
make
```

Watch for changes and rebuild:

```sh
make watch
```

Clean generated auxiliary files:

```sh
make clean
```

Remove all generated build output:

```sh
make distclean
```

The compiled PDF is written to `build/main.pdf`.

## Notes

This project currently uses the `conference` option from the provided IEEE
template:

```tex
\documentclass[conference]{IEEEtran}
```

If the final target is an IEEE journal rather than a conference paper, change
that line to the appropriate IEEEtran journal mode before final formatting.

After adding the first citation, uncomment the bibliography lines at the end of
`main.tex`. They currently use the locally available `ieeetr` BibTeX style so
the project builds on a minimal TeX Live installation. If `IEEEtran.bst` is
installed later, switch the style line to:

```tex
\bibliographystyle{IEEEtran}
```
