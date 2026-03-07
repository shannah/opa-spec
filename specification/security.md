---
layout: default
title: Security
parent: Specification
nav_order: 8
permalink: /specification/security/
---

# Security Considerations
{: .fs-8 }

Path traversal, prompt injection, resource limits, signing, and sensitive data handling.
{: .fs-5 .fw-300 .text-grey-dk-000 }

---

## Path Traversal

Clients MUST validate all archive entry paths before extraction (see [File Format — Path Safety](../file-format/#path-safety)). Any path containing `..` or beginning with `/` MUST cause the client to reject the archive.

---

## Prompt Injection

Session history and data assets are user-supplied content and MUST be treated as untrusted by the client.

{: .warning }
> Clients SHOULD inform users when executing archives from unknown sources. Agents SHOULD be instructed not to follow instructions embedded in data assets that conflict with the primary prompt.

---

## Resource Limits

Clients operating in `autonomous` mode MUST enforce maximum turn counts and token budgets to prevent runaway execution.

### Recommended Defaults

| Limit | Value |
|:------|:------|
| Maximum turns | 50 |
| Maximum tokens | 200,000 |

---

## Signing (Future Work)

A signing extension is planned to allow archive authors to sign manifests and contents. Until ratified, clients MAY implement signing using `META-INF/SIGNATURE.SF` following the JAR signing convention.

---

## Sensitive Data

Archives MAY contain sensitive data. Authors SHOULD encrypt archives containing credentials, PII, or proprietary information.

The core format does not mandate encryption; an encryption extension is anticipated.
