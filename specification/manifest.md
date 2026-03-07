---
layout: default
title: Manifest
parent: Specification
nav_order: 2
permalink: /specification/manifest/
---

# Manifest
{: .fs-8 }

The `META-INF/MANIFEST.MF` file — format, required fields, and optional fields.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Format

The manifest follows the [JAR manifest format](https://docs.oracle.com/en/java/docs/specs/jar/jar.html#jar-manifest): a sequence of `Name: Value` pairs separated by newlines, with sections separated by blank lines. Lines MUST NOT exceed 72 bytes; long values are continued by beginning the next line with a single space.

---

## Required Fields

| Field | Description |
|:------|:------------|
| `Manifest-Version` | MUST be `1.0`. |
| `OPA-Version` | The OPA specification version. MUST be `0.1` for this revision. |
| `Prompt-File` | Archive-relative path to the primary prompt file. Defaults to `prompt.md`. |

---

## Optional Fields

| Field | Description |
|:------|:------------|
| `Created-By` | Free-form string identifying the tool that created the archive. |
| `Created-At` | ISO 8601 UTC timestamp of archive creation (e.g., `2026-03-04T12:00:00Z`). |
| `Title` | Short human-readable title for the task. |
| `Description` | One-line summary of the archive's purpose. |
| `Agent-Hint` | RECOMMENDED model family or capability hint (e.g., `claude-3`, `gpt-4o`). Non-normative. Clients MAY ignore. |
| `Session-File` | Archive-relative path to the session history file. Defaults to `session/history.json` if `session/` exists. |
| `Data-Root` | Archive-relative path to the data asset root directory. Defaults to `data/`. |
| `Execution-Mode` | One of `interactive`, `batch`, or `autonomous`. Default: `interactive`. See [Execution Model](../execution-model/). |
| `Schema-Extensions` | Space-separated list of extension URIs declared by this archive. See [Extensions](../extensions/). |

---

## Example Manifest

```
Manifest-Version: 1.0
OPA-Version: 0.1
Title: Summarise Q1 Sales Reports
Description: Summarise the attached regional CSV files and draft an execut
 ive brief.
Created-By: opa-cli 1.0.0
Created-At: 2026-03-04T09:15:00Z
Agent-Hint: claude-sonnet
Execution-Mode: batch
Prompt-File: prompt.md
Session-File: session/history.json
Data-Root: data/
```

{: .note }
> Long values are continued by beginning the next line with a single space, as shown in the `Description` field above.

---

## Field Summary

| Field | Required | Default |
|:------|:---------|:--------|
| `Manifest-Version` | Yes | — |
| `OPA-Version` | Yes | — |
| `Prompt-File` | No | `prompt.md` |
| `Session-File` | No | `session/history.json` |
| `Data-Root` | No | `data/` |
| `Execution-Mode` | No | `interactive` |
| `Title` | No | — |
| `Description` | No | — |
| `Agent-Hint` | No | — |
| `Created-By` | No | — |
| `Created-At` | No | — |
| `Schema-Extensions` | No | — |
