---
layout: default
title: Session History
parent: Specification
nav_order: 4
permalink: /specification/session-history/
---

# Session History
{: .fs-8 }

The `session/history.json` file — purpose, schema, message roles, and content blocks.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Purpose

The session history records prior interactions between a user and an agent. Clients MUST include session history in the agent context, prepended before the prompt, when executing an archive that contains a `session/history.json`.

---

## Schema

`history.json` is a UTF-8 encoded JSON document conforming to the following structure:

```json
{
  "opa_version": "0.1",
  "session_id": "<UUID v4>",
  "created_at": "<ISO 8601 UTC>",
  "updated_at": "<ISO 8601 UTC>",
  "messages": [
    {
      "id": "<UUID v4 or sequential integer string>",
      "role": "user | assistant | system | tool",
      "content": "<string or content block array>",
      "timestamp": "<ISO 8601 UTC>",
      "metadata": {}
    }
  ]
}
```

---

## Message Roles

| Role | Description |
|:-----|:------------|
| `user` | Message originating from the human operator. |
| `assistant` | Message originating from the AI agent. |
| `system` | System-level instruction. Clients MAY inject before user messages. |
| `tool` | Result of a tool call. Clients that do not support tool use MAY omit these messages or convert them to `user` messages. |

---

## Content Blocks

The `content` field MAY be a plain string or an array of content block objects, enabling multi-modal history.

### Content Block Types

```json
{ "type": "text", "text": "..." }
```

```json
{ "type": "image", "source": { "type": "attachment", "path": "session/attachments/image.png" } }
```

```json
{ "type": "file", "source": { "type": "attachment", "path": "session/attachments/report.pdf" } }
```

```json
{ "type": "tool_use", "id": "...", "name": "...", "input": {} }
```

```json
{ "type": "tool_result", "tool_use_id": "...", "content": "..." }
```

Attachment paths are archive-relative. Clients MUST extract referenced attachments before passing them to the agent.

---

## Example

```json
{
  "opa_version": "0.1",
  "session_id": "f47ac10b-58cc-4372-a567-0e02b2c3d479",
  "created_at": "2026-03-01T10:00:00Z",
  "updated_at": "2026-03-03T17:45:00Z",
  "messages": [
    {
      "id": "1",
      "role": "user",
      "content": "Can you start by reviewing the north region data?",
      "timestamp": "2026-03-01T10:00:00Z"
    },
    {
      "id": "2",
      "role": "assistant",
      "content": "Sure! I can see the north region CSV has three sheets...",
      "timestamp": "2026-03-01T10:00:05Z"
    }
  ]
}
```

---

## JSON Schema

The formal JSON Schema for `history.json`:

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://opa.dev/schema/history/0.1",
  "type": "object",
  "required": ["opa_version", "session_id", "messages"],
  "properties": {
    "opa_version": { "type": "string" },
    "session_id":   { "type": "string", "format": "uuid" },
    "created_at":   { "type": "string", "format": "date-time" },
    "updated_at":   { "type": "string", "format": "date-time" },
    "messages": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["role", "content"],
        "properties": {
          "id":        { "type": "string" },
          "role":      { "enum": ["user", "assistant", "system", "tool"] },
          "content":   {},
          "timestamp": { "type": "string", "format": "date-time" },
          "metadata":  { "type": "object" }
        }
      }
    }
  }
}
```
