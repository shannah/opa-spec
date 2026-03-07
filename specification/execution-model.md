---
layout: default
title: Execution Model
parent: Specification
nav_order: 6
permalink: /specification/execution-model/
---

# Execution Model
{: .fs-8 }

Client responsibilities, execution modes, output conventions, and environment variables.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Client Responsibilities

A conformant client MUST:

1. Validate the archive (ZIP integrity, manifest presence, OPA-Version recognition).
2. Extract the archive into an isolated environment.
3. Resolve the prompt file and session history per the manifest.
4. Construct the agent context: system messages (if any) → session history messages → prompt.
5. Invoke the agent with the constructed context.
6. Provide the `data/` directory to the agent via the container filesystem or equivalent mechanism.

---

## Execution Modes

| Mode | Behaviour |
|:-----|:----------|
| `interactive` | Client presents agent responses to the user in real time; user may send follow-up messages. Session history SHOULD be updated by the client. |
| `batch` | Client runs the prompt to completion without user interaction. Output is captured and SHOULD be written to `output/` within the container. |
| `autonomous` | Agent may invoke tools and loop until a terminal condition is met. Client MUST enforce a configurable turn or token limit. |

The execution mode is specified in the manifest via the `Execution-Mode` field. If not specified, the default is `interactive`.

---

## Output Convention

Clients operating in `batch` or `autonomous` mode SHOULD write agent output to an `output/` directory inside the container at `$OPA_OUTPUT_ROOT`.

Clients MAY package the output directory back into a new OPA archive with an updated session history for chaining.

---

## Environment Variables

Clients MUST set the following environment variables in the container:

| Variable | Value |
|:---------|:------|
| `OPA_VERSION` | The `OPA-Version` from the manifest. |
| `OPA_ARCHIVE_NAME` | The base filename of the archive (no extension). |
| `OPA_EXTRACTED_ROOT` | Absolute path to the extracted archive root. |
| `OPA_DATA_ROOT` | Absolute path to the extracted `data/` directory. |
| `OPA_OUTPUT_ROOT` | Absolute path to the designated output directory. |
| `OPA_EXECUTION_MODE` | The resolved execution mode. |

---

## Reference Implementation

A minimal client implementation MUST:

- Accept a path to a `.opa` file.
- Extract the archive to a temporary directory with path-safety validation.
- Parse `META-INF/MANIFEST.MF`.
- Read `prompt.md` (or the value of `Prompt-File`).
- If `session/history.json` exists, parse and prepend it to the agent context.
- Invoke the configured agent with the full context.
- Set the required environment variables.

A reference CLI implementation (`opa-run`) and a Java library (`opa-core`) are planned as companion deliverables to this specification.
