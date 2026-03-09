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

[Get OPA Runner](/opa-spec/runner/){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View Specification](/opa-spec/specification/){: .btn .fs-5 .mb-4 .mb-md-0 .mr-2 }
[View on GitHub](https://github.com/shannah/opa-spec){: .btn .fs-5 .mb-4 .mb-md-0 }

---

<div class="hero-cards" markdown="1">

{: .note }
> **Ready to run OPA files?** Download [OPA Runner](/opa-spec/runner/) — a cross-platform desktop app for opening and executing `.opa` archives in sandboxed containers. Available for Windows, macOS, and Linux.

</div>

---

## Why OPA?

Running AI analysis on the server is expensive. OPA lets you **package data with analysis instructions** and distribute it to users who run it with their own AI — shifting costs, preserving privacy, and giving users the flexibility to add their own context.

<img src="/opa-spec/assets/images/opa-end-to-end-flow.svg" alt="How OPA bridges server intelligence and user context" style="width:100%; max-width:960px; margin:1.5rem auto; display:block;" />

[See Use Cases](/opa-spec/use-cases/){: .btn .btn-outline }

---

## What is OPA?

The **Open Prompt Archive** is a ZIP-based, portable archive format (`.opa`) that packages everything needed to execute an AI agent task:

- **A prompt** — the primary instruction for the agent
- **Session history** — prior conversation context for continuity
- **Data assets** — files the prompt references and the agent can access
- **Metadata** — manifest describing the archive and execution parameters

OPA archives are distributable units that any compatible client can extract and execute using any AI agent in a sandboxed container environment.

<img src="/opa-spec/assets/images/opa-architecture-overview.svg" alt="OPA Architecture Overview" style="width:100%; max-width:800px; margin:1rem auto; display:block;" />

---

## Get Started

<div class="getting-started-grid" markdown="1">

### Run OPA Files
{: .fs-6 }

Download **OPA Runner** to open and execute `.opa` files on your desktop.

[Download OPA Runner](/opa-spec/runner/){: .btn .btn-primary }

### Create OPA Files
{: .fs-6 }

Use an official library to generate OPA archives in your preferred language.

[Browse Libraries](/opa-spec/libraries/){: .btn .btn-primary }

### Read the Spec
{: .fs-6 }

Dive into the full specification to understand the format and build your own tools.

[View Specification](/opa-spec/specification/){: .btn .btn-outline }

### Explore Use Cases
{: .fs-6 }

See real-world examples of OPA in action, from inventory analysis to compliance audits.

[View Use Cases](/opa-spec/use-cases/){: .btn .btn-outline }

</div>

---

## Language Support

Official libraries are available for five languages:

| Language | Package | Install |
|:---------|:--------|:--------|
| **Java** | [opa-java](https://github.com/shannah/opa-java) | Maven: `ca.weblite:opa-core` |
| **JavaScript** | [opa-js](https://github.com/shannah/opa-js) | `npm install opa-js` |
| **Python** | [opa-python](https://github.com/shannah/opa-python) | `pip install opa-archive` |
| **PHP** | [opa-php](https://github.com/shannah/opa-php) | `composer require opa/opa-php` |
| **Ruby** | [opa-ruby](https://github.com/shannah/opa-ruby) | `gem install opa-ruby` |

[See all libraries](/opa-spec/libraries/){: .btn .btn-outline }

---

## Key Design Principles

<img src="/opa-spec/assets/images/design-principles.svg" alt="Design Principles" style="width:100%; max-width:800px; margin:1rem auto; display:block;" />

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

## Status

{: .warning }
> This specification is currently in **Draft** status (v0.1.0). Version 1.0 will be published following at least two independent interoperable implementations.
