#!/usr/bin/env python
"""
Turn a commented R script into a Google Colab notebook with the R runtime.

    python tools/r_to_colab.py lecture03/lecture03_tidyverse.R colab/lecture03_tidyverse.ipynb \
        --title "Lecture 3: Introduction to the Tidyverse"

How the script is split
    * A block of ###### lines with a comment inside becomes a Markdown heading
      plus the comment text, so students can read the notebook top to bottom.
    * Code lines are grouped by blank lines; every group becomes one code cell,
      one result per cell, exactly like the benchmark repository.
    * The notebook opens in the R runtime automatically (kernelspec "ir"), so
      students do not need to change anything in Colab.
"""

import argparse
import json
import re

SECTION_RULE = re.compile(r"^#{10,}\s*$")


def parse_script(text):
    lines = text.splitlines()
    i, n = 0, len(lines)
    cells = []

    # skip the file's own banner (first ##### block) but keep its text as intro
    def flush_code(buf):
        code = "\n".join(buf).strip("\n")
        if code.strip():
            cells.append(("code", code))

    buf = []
    seen_section = False
    while i < n:
        line = lines[i]
        if SECTION_RULE.match(line):
            flush_code(buf); buf = []
            # collect the comment lines until the closing rule
            j = i + 1
            comment = []
            while j < n and not SECTION_RULE.match(lines[j]):
                comment.append(lines[j])
                j += 1
            i = j + 1
            # the very first block is the script's file banner ("how to use
            # this file" in RStudio). The notebook has its own intro, so skip it.
            if not seen_section:
                seen_section = True
                continue
            text_lines = [c.lstrip("#").rstrip() for c in comment]
            text_lines = [t[1:] if t.startswith(" ") else t for t in text_lines]
            # first non-empty line is the heading
            body = [t for t in text_lines]
            while body and not body[0].strip():
                body.pop(0)
            if not body:
                continue
            head = body[0].strip()
            rest = "\n".join(body[1:]).strip("\n")
            md = f"## {head}"
            if rest.strip():
                md += "\n\n" + "\n".join(l.strip() for l in rest.splitlines())
            cells.append(("markdown", md))
            continue
        if line.strip() == "":
            flush_code(buf); buf = []
        else:
            buf.append(line)
        i += 1
    flush_code(buf)
    return cells


def build_notebook(cells, title, intro):
    nb_cells = []

    def md(src):
        return {"cell_type": "markdown", "metadata": {}, "source": src}

    def code(src):
        return {"cell_type": "code", "metadata": {}, "execution_count": None,
                "outputs": [], "source": src}

    nb_cells.append(md(f"# {title}\n\n{intro}"))
    nb_cells.append(md("## Setup\n\nRun this cell first. Colab's R runtime already has the tidyverse; "
                       "this only installs it if it is somehow missing."))
    nb_cells.append(code(
        'if (!requireNamespace("tidyverse", quietly = TRUE)) install.packages("tidyverse")\n'
        "library(tidyverse)\n"
        'cat("tidyverse loaded, R", R.version.string, "\\n")'))
    for kind, src in cells:
        nb_cells.append(md(src) if kind == "markdown" else code(src))

    return {
        "cells": nb_cells,
        "metadata": {
            "kernelspec": {"display_name": "R", "language": "R", "name": "ir"},
            "language_info": {"name": "R", "file_extension": ".r",
                              "mimetype": "text/x-r-source"},
            "colab": {"provenance": [], "toc_visible": True},
        },
        "nbformat": 4,
        "nbformat_minor": 5,
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("script")
    ap.add_argument("notebook")
    ap.add_argument("--title", default="Lecture notebook")
    ap.add_argument("--intro", default=(
        "**ØKA2015 Applied Data Science, University of Inland Norway.** Touseef Hameed.\n\n"
        "This notebook is the lecture's R script, split into one result per cell. "
        "It runs in Google Colab with no installation: it is already set to the R runtime, "
        "so just press the play button on each cell in order. The same code lives in the "
        "`.R` file in this repository if you prefer RStudio on your own laptop, which is "
        "where the assignments are written."))
    a = ap.parse_args()

    text = open(a.script, encoding="utf-8").read()
    cells = parse_script(text)
    nb = build_notebook(cells, a.title, a.intro)
    with open(a.notebook, "w", encoding="utf-8") as f:
        json.dump(nb, f, indent=1, ensure_ascii=False)
    n_code = sum(1 for c in nb["cells"] if c["cell_type"] == "code")
    print(f"wrote {a.notebook}: {len(nb['cells'])} cells ({n_code} code)")


if __name__ == "__main__":
    main()
