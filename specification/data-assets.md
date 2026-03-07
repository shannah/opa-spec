---
layout: default
title: Data Assets
parent: Specification
nav_order: 5
permalink: /specification/data-assets/
---

# Data Assets
{: .fs-8 }

The `data/` directory — contents, structure, and optional data index.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Contents

The `data/` directory MAY contain any files and subdirectories. There are no restrictions on file type, name, or depth. Clients MUST extract the `data/` tree to the container filesystem and SHOULD make it available to the agent under a predictable path (e.g., `$OPA_DATA_ROOT`).

---

## Data Index (Optional)

An archive MAY include a `data/INDEX.json` file enumerating the data assets with optional descriptions:

```json
{
  "assets": [
    {
      "path": "data/q1/north-region.csv",
      "description": "Q1 sales figures, North Region",
      "content_type": "text/csv"
    }
  ]
}
```

### Index Fields

| Field | Required | Description |
|:------|:---------|:------------|
| `path` | Yes | Archive-relative path to the asset. |
| `description` | No | Human-readable description of the asset. |
| `content_type` | No | MIME type of the asset. |

Clients MAY surface this index to agents as additional context.

---

## Example Structure

```
data/
├── INDEX.json
├── q1/
│   ├── north-region.csv
│   └── south-region.csv
└── reference/
    └── targets-2026.xlsx
```
