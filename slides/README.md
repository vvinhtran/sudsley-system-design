# Slides

Four Beamer decks, one per lecture. The PDFs are ready to present. Overlays reveal list
items and code-review points one at a time.

| Deck | Lecture |
|---|---|
| [`1-introduction.pdf`](1-introduction.pdf) | The Sudsley scenario, product ideas, the MVP, and high-level design (HW1) |
| [`2-high-level-and-component-design.pdf`](2-high-level-and-component-design.pdf) | The model high-level design and the thirteen questions on the User Service (HW2) |
| [`3-component-implementation.pdf`](3-component-implementation.pdf) | Approaching an unfamiliar codebase (HW3) |
| [`4-code-review-and-analysis.pdf`](4-code-review-and-analysis.pdf) | Engineering currency and code samples A–E |

## Editing

Each deck is a `.tex` file sharing the theme in `sudsley.sty`. Build one with a TeX
distribution that includes Beamer and the `moloch` theme (TeX Live 2024 or later):

```sh
latexmk -pdf 1-introduction.tex
```

The two architecture diagrams are Mermaid sources in `figures/`, rendered to PDF with
[mermaid-cli](https://github.com/mermaid-js/mermaid-cli):

```sh
npx -y @mermaid-js/mermaid-cli -i figures/high-level-design.mmd -o figures/high-level-design.pdf --pdfFit
```

The same diagrams appear in `scenario/high-level-design.md` and
`framework/component-architecture-questions.md`. Change both copies together.
