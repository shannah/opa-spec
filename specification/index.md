---
layout: default
title: Specification
nav_order: 4
has_children: true
permalink: /specification/
---

# OPA Specification
{: .fs-9 }

Version 0.1.0 — Draft
{: .fs-6 .fw-300 .text-grey-dk-000 }

---

This specification defines the **Open Prompt Archive (OPA)**, a portable, self-contained archive format for packaging AI agent prompts together with their session history, data assets, and execution metadata. OPA archives are distributable units that clients can extract and execute using any compatible AI agent in a sandboxed container environment. The format is based on the ZIP container (as used by JAR), ensuring broad toolchain compatibility.

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [BCP 14](https://datatracker.ietf.org/doc/html/bcp14) \[[RFC 2119](https://www.rfc-editor.org/rfc/rfc2119)] \[[RFC 8174](https://datatracker.ietf.org/doc/html/rfc8174)] when, and only when, they appear in all capitals.

---

## Motivation

Modern AI-assisted workflows increasingly involve:

- **Reproducible prompt execution** — the ability to run a prompt against identical context and data, yielding consistent results.
- **Shareable agent tasks** — distributing a well-defined task (prompt + data) to another party or machine.
- **Session continuity** — preserving conversation history so agents can resume or audit a prior session.
- **Agent-agnostic portability** — decoupling the task definition from any specific AI provider or runtime.

No existing standard addresses all of these concerns in a single, self-describing, portable unit. OPA fills this gap by defining a minimal, open archive format that any client can execute by extracting its contents and invoking a conformant AI agent.

---

## Design Goals

1. **Agent-agnostic.** The format must not assume a specific AI provider, model, or API. Clients choose their own agent.
2. **Container-friendly.** Archives must be straightforwardly extractable into a container filesystem for sandboxed execution.
3. **Human-readable metadata.** Manifest and prompt files must be plain text or common structured formats (JSON, YAML, Markdown).
4. **Toolchain compatible.** The archive format must be openable by standard ZIP tools (including `jar`, `unzip`, `7-Zip`).
5. **Extensible.** New capability fields can be added without breaking older clients.
6. **Minimal.** A valid OPA archive requires only a manifest and a prompt file.

---

## Terminology

| Term | Definition |
|:-----|:-----------|
| **Archive** | A single OPA file (`.opa`). |
| **Client** | Software that reads and executes an OPA archive. |
| **Agent** | The AI model or service invoked by the client to process the prompt. |
| **Session** | A recorded sequence of prior agent interactions included in the archive. |
| **Prompt** | The primary instruction or task specification for the agent. |
| **Data asset** | Any file included in the archive that the prompt may reference. |
| **Container** | An isolated execution environment (e.g., Docker, Podman, OCI sandbox) into which the archive is extracted. |

---

## Specification Components

<img src="/opa-spec/assets/images/opa-specification-map.svg" alt="OPA Specification Map" style="width:100%; max-width:800px; margin:1rem auto; display:block;" />

<div class="spec-grid" markdown="1">

<a href="file-format/">
<h4>File Format</h4>
<p>ZIP-based container, directory structure, and path safety</p>
</a>

<a href="manifest/">
<h4>Manifest</h4>
<p>META-INF/MANIFEST.MF required and optional fields</p>
</a>

<a href="prompt-file/">
<h4>Prompt File</h4>
<p>Prompt format, data asset references, and template variables</p>
</a>

<a href="session-history/">
<h4>Session History</h4>
<p>session/history.json schema and message format</p>
</a>

<a href="data-assets/">
<h4>Data Assets</h4>
<p>The data/ directory and optional data index</p>
</a>

<a href="execution-model/">
<h4>Execution Model</h4>
<p>Client responsibilities, execution modes, and environment</p>
</a>

<a href="extensions/">
<h4>Extensions</h4>
<p>Extension declaration, files, and namespaces</p>
</a>

<a href="security/">
<h4>Security</h4>
<p>Path traversal, prompt injection, resource limits</p>
</a>

</div>

---

## MIME Type and File Extension

| Property | Value |
|:---------|:------|
| File extension | `.opa` |
| MIME type | `application/vnd.opa+zip` |
| Alternative extension | `.opa.jar` (for JAR toolchain compatibility) |

---

## Versioning

The `OPA-Version` field in the manifest identifies the specification version. Clients SHOULD warn and MAY refuse to execute archives with a higher major version than they support. Minor version increments are backwards-compatible additions.

This document defines version `0.1`. Version `1.0` will be published following at least two independent interoperable implementations.

---

## Relation to Existing Formats

| Format | Relationship |
|:-------|:-------------|
| **JAR** | OPA uses the same ZIP-based container and manifest syntax. JAR tooling can inspect and extract OPA archives. |
| **OCI Image** | OPA is not an OCI image; it is extracted *into* an OCI container, not used *as* one. |
| **LangChain serialization** | OPA is agent-agnostic and does not encode framework-specific chain definitions. |
| **OpenAI Assistant files** | OPA is format-level; it does not encode provider-specific assistant configuration. |

---

## Changelog

| Version | Date | Notes |
|:--------|:-----|:------|
| 0.1.0 | 2026-03-04 | Initial draft. |
