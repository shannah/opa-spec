---
layout: default
title: OPA Runner
nav_order: 2
description: "OPA Runner — A desktop application for opening and running OPA files."
permalink: /runner/
---

# OPA Runner
{: .fs-9 }

A desktop application that opens and executes OPA archives in isolated containers.
{: .fs-6 .fw-300 }

[Download OPA Runner](https://www.jdeploy.com/gh/shannah/opa-runner-releases){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

## What is OPA Runner?

OPA Runner is a cross-platform desktop application that brings OPA files to life. Double-click any `.opa` file to open it in a sandboxed environment where the bundled prompt, data assets, and session history are loaded and executed by an AI agent.

<img src="/assets/images/opa-runner-flow.svg" alt="How OPA Runner Works" style="width:100%; max-width:800px; margin:1rem auto; display:block;" />

---

## Platform Support

OPA Runner is available for all major operating systems:

| Platform | Architectures | Minimum Version |
|:---------|:-------------|:----------------|
| **Windows** | x86_64, ARM64 | Windows 7+ |
| **macOS** | Intel, Apple Silicon | macOS 10.14+ |
| **Linux** | x86_64, ARM64 | Modern distributions |

---

## Getting Started

1. **Download** OPA Runner for your platform from the [releases page](https://www.jdeploy.com/gh/shannah/opa-runner-releases)
2. **Install** the application using the platform-appropriate installer
3. **Open** any `.opa` file — either double-click it or use File > Open from within the app
4. **Run** the bundled prompt and watch the AI agent execute the task

---

## Creating OPA Files

To create `.opa` files that you can open with OPA Runner, use one of the official [language libraries](/libraries/):

- **Java** — `opa-java`
- **JavaScript** — `opa-js`
- **Python** — `opa-archive`
- **PHP** — `opa-php`
- **Ruby** — `opa-ruby`

Or build archives manually following the [specification](/specification/) — they're just ZIP files with a specific structure.
