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

## Signing

OPA archives support digital signing following the [JAR signing convention](https://docs.oracle.com/en/java/docs/specs/jar/jar.html#signed-jar-file). Signing allows archive consumers to verify the identity of the author and the integrity of the archive contents.

### Signature Files

A signed archive MUST contain a **signature file** and a **signature block file** in the `META-INF/` directory:

| File | Description |
|:-----|:------------|
| `META-INF/SIGNATURE.SF` | The signature file. Contains digests of the manifest and its individual sections. |
| `META-INF/SIGNATURE.RSA`, `.DSA`, or `.EC` | The signature block file. Contains the PKCS #7 digital signature of `SIGNATURE.SF`. The extension indicates the algorithm used. |

### Signature File Format

The signature file (`SIGNATURE.SF`) follows the JAR `.SF` format:

```
Signature-Version: 1.0
Created-By: opa-cli 1.0.0
SHA-256-Digest-Manifest: <base64-encoded digest of entire MANIFEST.MF>

Name: prompt.md
SHA-256-Digest: <base64-encoded digest of the prompt.md section in MANIFEST.MF>

Name: data/report.csv
SHA-256-Digest: <base64-encoded digest of the data/report.csv section in MANIFEST.MF>
```

The main section MUST include `Signature-Version: 1.0` and a digest of the entire manifest file. Each individual section contains a digest of the corresponding named section in `META-INF/MANIFEST.MF`.

### Digest Algorithms

Implementations MUST support `SHA-256`. Implementations MAY additionally support `SHA-384` and `SHA-512`. Implementations MUST NOT accept `MD5` or `SHA-1` digests.

### Verification

Clients MUST verify signatures when all of the following are true:

1. The archive contains a `META-INF/SIGNATURE.SF` file.
2. A corresponding signature block file (`META-INF/SIGNATURE.RSA`, `.DSA`, or `.EC`) is present.

Verification proceeds as follows:

1. Verify the digital signature in the signature block file against `SIGNATURE.SF`.
2. Verify that the manifest digest in `SIGNATURE.SF` matches the actual `MANIFEST.MF` contents.
3. For each named entry in `SIGNATURE.SF`, verify that the section digest matches the corresponding section in `MANIFEST.MF`.

If any verification step fails, the client MUST reject the archive.

{: .warning }
> Clients SHOULD NOT execute unsigned archives in `autonomous` mode unless the user has explicitly opted in. Signed archives provide stronger guarantees about provenance and integrity.

### Trust

Clients MUST maintain a trust store of accepted certificates or public keys. The mechanism for managing the trust store (e.g., configuration file, system keychain, command-line flags) is implementation-defined.

{: .note }
> Clients MAY support a `--trust-unsigned` or equivalent flag to allow execution of unsigned archives. This flag SHOULD default to disabled.

---

## Sensitive Data

Archives MAY contain sensitive data. Authors SHOULD encrypt archives containing credentials, PII, or proprietary information.

The core format does not mandate encryption; an encryption extension is anticipated.
