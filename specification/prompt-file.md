---
layout: default
title: Prompt File
parent: Specification
nav_order: 3
permalink: /specification/prompt-file/
---

# Prompt File
{: .fs-8 }

The primary prompt document — format, data asset references, and template variables.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Format

The prompt file is a **UTF-8 encoded Markdown** document. Clients MUST pass the full content of this file to the agent as the initial user message (or system prompt, per client policy — see [Execution Model](../execution-model/)).

---

## Data Asset References

The prompt MAY reference data assets using paths relative to the archive root, enclosed in backticks or written as bare relative paths. Clients SHOULD resolve these references against the extracted archive directory and make the referenced files available to the agent (e.g., by including their content inline, providing file paths, or mounting them into the container).

### Example Reference Syntax

```markdown
Please analyse the sales data in `data/q1/north-region.csv` and compare
it against `data/q1/south-region.csv`.
```

{: .note }
> The exact syntax for data asset references is non-normative. Clients MAY support additional reference syntaxes beyond backtick-enclosed paths.

---

## Template Variables

Prompt files MAY include template variables using the syntax `{% raw %}{{variable_name}}{% endraw %}`. Clients MAY substitute these at runtime.

### Reserved Variables

The following variable names are RESERVED and have defined substitution values:

| Variable | Substituted With |
|:---------|:----------------|
| `{% raw %}{{archive_name}}{% endraw %}` | The base filename of the archive (without extension). |
| `{% raw %}{{extracted_path}}{% endraw %}` | Absolute path to the extracted archive root in the container. |
| `{% raw %}{{timestamp}}{% endraw %}` | ISO 8601 UTC execution time. |
| `{% raw %}{{agent}}{% endraw %}` | The agent identifier selected by the client. |

### Example Usage

```markdown
# Task: {% raw %}{{archive_name}}{% endraw %}

You are running at {% raw %}{{timestamp}}{% endraw %} using {% raw %}{{agent}}{% endraw %}.

Please analyse the sales data in `data/q1/north-region.csv` and write
your report to `{% raw %}{{extracted_path}}{% endraw %}/output/report.md`.
```
