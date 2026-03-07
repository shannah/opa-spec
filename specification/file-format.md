---
layout: default
title: File Format
parent: Specification
nav_order: 1
permalink: /specification/file-format/
---

# File Format
{: .fs-8 }

The OPA archive container, directory structure, and path safety rules.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Container

An OPA archive is a **ZIP file** with the extension `.opa`. Implementations SHOULD also accept `.opa.jar` for interoperability with JAR-based toolchains. The ZIP central directory MUST be present and valid. ZIP64 extensions are permitted for archives exceeding 4 GB.

Archives SHOULD use `DEFLATE` compression for text-based entries and MAY use `STORE` for binary data assets where compression yields negligible benefit.

---

## Directory Structure

```
<archive>.opa
│
├── META-INF/
│   ├── MANIFEST.MF          # Required. Archive manifest.
│   ├── SIGNATURE.SF         # Optional. Signature file (if signed).
│   └── SIGNATURE.{RSA,DSA,EC} # Optional. Signature block (if signed).
│
├── prompt.md                # Required. The primary prompt file.
│
├── session/                 # Optional. Session history directory.
│   ├── history.json         # Required if session/ present.
│   └── attachments/         # Optional. Files referenced in session messages.
│       └── <any files>
│
└── data/                    # Optional. Data assets for the prompt.
    └── <arbitrary files and subdirectories>
```

### Required Entries

| Entry | Description |
|:------|:------------|
| `META-INF/MANIFEST.MF` | The archive manifest. See [Manifest](../manifest/). |
| `prompt.md` | The primary prompt file. See [Prompt File](../prompt-file/). |

### Optional Entries

| Entry | Description |
|:------|:------------|
| `META-INF/SIGNATURE.SF` | Signature file. Present in signed archives. See [Security — Signing](../security/#signing). |
| `META-INF/SIGNATURE.{RSA,DSA,EC}` | Signature block file. Present in signed archives. |
| `session/history.json` | Session history. Required if `session/` directory is present. See [Session History](../session-history/). |
| `session/attachments/` | Files referenced in session messages. |
| `data/` | Data assets for the prompt. See [Data Assets](../data-assets/). |

### Forward Compatibility

Clients MUST treat any path outside of `META-INF/`, `session/`, and `data/` (other than `prompt.md`) as a data asset if encountered, for forward compatibility.

---

## Path Safety

All entry paths within the archive MUST use forward-slash (`/`) separators.

Clients MUST reject archives containing paths with:
- `..` components (directory traversal)
- Absolute paths (paths beginning with `/`)

This prevents path traversal attacks during extraction. See [Security](../security/) for additional considerations.
