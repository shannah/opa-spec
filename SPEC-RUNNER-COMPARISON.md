# OPA Specification vs. Runner Implementation — Discrepancy Report

This document compares the OPA specification (`opa-spec/specification/`) against the
`opa-runner` implementation and identifies discrepancies where the runner diverges from
what the spec requires, recommends, or allows.

> **Scope:** Only discrepancies relevant to the *file format specification* are listed.
> Runner-only concerns (GUI, profiles, MCP servers, multi-agent support, Docker image
> building, credential management, etc.) are out of scope.

---

## 1. Session History Is Not Read (CRITICAL)

**Spec requirement (MUST):**
> "Clients MUST include session history in the agent context, prepended before the
> prompt, when executing an archive that contains a `session/history.json`."
> — `session-history.md`

**Runner behaviour:**
`ZipArchiveReader.read()` hard-codes `Optional.empty()` for session history with the
comment `// Session history — Phase 2` (line 50). The session history JSON file is
extracted to disk but **never parsed or passed to the agent**. The `SessionHistory`,
`Message`, and `MessageRole` domain types exist but are unused at runtime.

**Impact:** Archives containing session history will silently lose all prior context.

---

## 2. Message Content Blocks Not Modelled

**Spec defines** that `Message.content` may be a plain string **or** an array of
typed content blocks (`text`, `image`, `file`, `tool_use`, `tool_result`):

```json
{ "type": "image", "source": { "type": "attachment", "path": "..." } }
```

**Runner model:**
`Message.java` declares `content` as a plain `String`. There is no support for
content block arrays, multi-modal content, or attachment references.

**Impact:** Any archive using structured content blocks will fail to parse or will
lose image/file/tool content.

---

## 3. Message `metadata` Field Not Modelled

**Spec defines** an optional `metadata` object on each message.

**Runner model:**
`Message.java` has no `metadata` field. Any metadata present in a session history
file will be silently dropped.

---

## 4. `Schema-Extensions` Manifest Field Not Parsed

**Spec defines:**
> `Schema-Extensions`: Space-separated list of extension URIs declared by this
> archive.

**Runner behaviour:**
`ManifestParser` does not read the `Schema-Extensions` attribute, and `Manifest.java`
has no corresponding field. Per spec, clients that do not recognise an extension "MUST
NOT fail; they MUST skip unknown extension data" — the runner satisfies the non-failure
requirement implicitly, but it cannot even report which extensions an archive declares.

---

## 5. `data/INDEX.json` Not Supported

**Spec allows (MAY):**
> An archive MAY include a `data/INDEX.json` file enumerating the data assets.

**Runner behaviour:**
The `REQUIREMENTS.md` mentions a `DataAssetIndex` type, but no such class exists in the
codebase. The data index is never parsed or surfaced to the agent.

**Impact:** Minor — this is optional. However, if an archive includes an index with
descriptions, the runner ignores potentially useful context the agent could use.

---

## 6. Signature Verification Incomplete

### 6a. Only RSA Signatures Supported

**Spec requires:**
> `META-INF/SIGNATURE.{RSA,DSA,EC}` — The extension indicates the algorithm used.

**Runner behaviour:**
`SignatureReader` only looks for `META-INF/SIGNATURE.RSA`. Archives signed with DSA or
EC algorithms will be treated as unsigned.

### 6b. No Digest Verification

**Spec requires (MUST):**
Verification involves checking (1) the digital signature against `SIGNATURE.SF`,
(2) the manifest digest in `SIGNATURE.SF` against `MANIFEST.MF`, and (3) per-entry
digest verification.

**Runner behaviour:**
`SignatureReader` extracts the **certificate** from `SIGNATURE.RSA` to display signer
identity but does **not verify** the signature itself, nor does it verify manifest or
entry digests. A tampered archive with a valid certificate would still appear "signed."

### 6c. Digest Algorithm Enforcement Not Implemented

**Spec requires:**
> Implementations MUST support SHA-256. Implementations MUST NOT accept MD5 or SHA-1.

**Runner behaviour:**
No digest algorithm checking is performed since digests are not verified at all.

---

## 7. `Prompt-File` Treated as Optional in Spec Field Summary but Required in Body Text

This is a **spec inconsistency** rather than a runner bug:

- The "Required Fields" table lists `Prompt-File` as required.
- The "Field Summary" table at the bottom marks it as `Required: No` with
  `Default: prompt.md`.

The runner treats it as optional with a default of `prompt.md`, which aligns with the
Field Summary table but not the Required Fields table.

**Recommendation:** Clarify in the spec — it should probably be optional with a
default, matching both the runner and the `Default: prompt.md` note.

---

## 8. OPA-Version Validation Too Strict

**Spec says (SHOULD/MAY):**
> Clients SHOULD warn and MAY refuse to execute archives with a higher major version.
> Minor version increments are backwards-compatible additions.

**Runner behaviour:**
`ArchiveValidator.validateManifest()` throws `OpaException` if `OPA-Version` is
anything other than exactly `"0.1"`. This means an archive at version `0.2` (a
backwards-compatible minor bump) would be rejected, contrary to the spec's guidance
that minor increments should be accepted.

---

## 9. Template Variable `{{agent}}` Hard-Coded

**Spec defines:**
> `{{agent}}` — The agent identifier selected by the client.

**Runner behaviour:**
`PromptResolver.resolve()` hard-codes `{{agent}}` → `"claude"` regardless of which
agent is actually selected (`AgentType` can be CLAUDE_CODE, CODEX, GEMINI, or AIDER).

---

## 10. Forward Compatibility for Unknown Paths Not Explicitly Handled

**Spec requires (MUST):**
> Clients MUST treat any path outside of `META-INF/`, `session/`, and `data/` (other
> than `prompt.md`) as a data asset if encountered, for forward compatibility.

**Runner behaviour:**
The `ZipArchiveReader` extracts all entries to disk, which implicitly preserves unknown
paths. However, there is no explicit logic to surface these as data assets to the agent.
The requirement is partially met by extraction but the semantic intent (treating them as
data assets) is not enforced.

---

## Summary Table

| # | Issue | Severity | Spec Keyword |
|:--|:------|:---------|:-------------|
| 1 | Session history not parsed or used | Critical | MUST |
| 2 | Content blocks not modelled | High | MAY (but needed for multi-modal) |
| 3 | Message metadata dropped | Low | Optional field |
| 4 | Schema-Extensions not parsed | Low | MUST NOT fail (satisfied implicitly) |
| 5 | data/INDEX.json not supported | Low | MAY |
| 6a | Only RSA signatures | Medium | Spec lists RSA/DSA/EC |
| 6b | No signature digest verification | High | MUST verify |
| 6c | No digest algorithm enforcement | Medium | MUST support SHA-256, MUST NOT accept MD5/SHA-1 |
| 7 | Spec inconsistency: Prompt-File required vs optional | N/A (spec) | — |
| 8 | OPA-Version too strict on minor bumps | Medium | SHOULD warn / MAY refuse |
| 9 | `{{agent}}` hard-coded to "claude" | Low | Defined substitution |
| 10 | Forward compatibility partial | Low | MUST treat as data asset |
