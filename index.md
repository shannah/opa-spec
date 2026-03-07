---
layout: default
title: Home
nav_order: 1
description: "Open Prompt Archive (OPA) — A portable archive format for AI agent prompts."
permalink: /
---

# Open Prompt Archive (OPA)
{: .fs-9 }

A portable, self-contained archive format for packaging AI agent prompts together with their session history, data assets, and execution metadata.
{: .fs-6 .fw-300 }

[View Specification](/opa-spec/specification/){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View on GitHub](https://github.com/shannah/opa-spec){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## What is OPA?

The **Open Prompt Archive** is a ZIP-based, portable archive format (`.opa`) that packages everything needed to execute an AI agent task:

- **A prompt** — the primary instruction for the agent
- **Session history** — prior conversation context for continuity
- **Data assets** — files the prompt references and the agent can access
- **Metadata** — manifest describing the archive and execution parameters

OPA archives are distributable units that any compatible client can extract and execute using any AI agent in a sandboxed container environment.

---

## Key Design Principles

| Principle | Description |
|:----------|:------------|
| **Agent-agnostic** | No assumption about a specific AI provider, model, or API |
| **Container-friendly** | Straightforwardly extractable into a container filesystem |
| **Human-readable** | Manifest and prompt files use plain text formats (Markdown, JSON) |
| **Toolchain compatible** | Openable by standard ZIP tools (`jar`, `unzip`, `7-Zip`) |
| **Extensible** | New capability fields can be added without breaking older clients |
| **Minimal** | A valid archive requires only a manifest and a prompt file |

---

## Quick Example

A typical OPA archive contains:

```
sales-summary.opa
│
├── META-INF/
│   └── MANIFEST.MF
│
├── prompt.md
│
├── session/
│   ├── history.json
│   └── attachments/
│       └── previous-draft.md
│
└── data/
    ├── INDEX.json
    ├── q1/
    │   ├── north-region.csv
    │   └── south-region.csv
    └── reference/
        └── targets-2026.xlsx
```

---

## Specification

The OPA specification is currently at **version 0.1.0** (Draft).

Explore the full specification:

- [Overview](/opa-spec/specification/) — Introduction, motivation, and design goals
- [File Format](/opa-spec/specification/file-format/) — Archive container and directory structure
- [Manifest](/opa-spec/specification/manifest/) — `META-INF/MANIFEST.MF` fields and format
- [Prompt File](/opa-spec/specification/prompt-file/) — Prompt format, data references, and template variables
- [Session History](/opa-spec/specification/session-history/) — `session/history.json` schema and message format
- [Data Assets](/opa-spec/specification/data-assets/) — The `data/` directory and optional index
- [Execution Model](/opa-spec/specification/execution-model/) — Client responsibilities, modes, and environment
- [Extensions](/opa-spec/specification/extensions/) — Extension declaration and namespaces
- [Security](/opa-spec/specification/security/) — Security considerations and best practices

---

## Status

{: .warning }
> This specification is currently in **Draft** status (v0.1.0). Version 1.0 will be published following at least two independent interoperable implementations.

