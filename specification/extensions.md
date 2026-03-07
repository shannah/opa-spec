---
layout: default
title: Extensions
parent: Specification
nav_order: 7
permalink: /specification/extensions/
---

# Extensions
{: .fs-8 }

Extension declaration, files, and reserved namespaces.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Overview

Extensions allow third parties to introduce new fields and behaviours without conflicting with the core specification.

---

## Extension Declaration

Extensions MUST be declared in the manifest's `Schema-Extensions` field as space-separated URIs:

```
Schema-Extensions: https://example.com/opa-ext/tool-config/v1
                   https://example.com/opa-ext/signing/v1
```

---

## Extension Files

Extension data SHOULD be stored in `META-INF/extensions/<extension-id>/`.

Clients that do not recognise an extension MUST NOT fail; they MUST skip unknown extension data.

### Example Structure

```
META-INF/
├── MANIFEST.MF
└── extensions/
    ├── tool-config/
    │   └── config.json
    └── signing/
        └── signature.sig
```

---

## Reserved Extension Namespace

The namespace `https://opa.dev/ext/` is reserved for officially ratified extensions. Third-party extensions MUST use their own domain.

{: .note }
> Planned official extensions include archive signing and content encryption. Until these are ratified, clients MAY implement signing using `META-INF/SIGNATURE.SF` following the JAR signing convention.
