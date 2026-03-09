---
layout: default
title: Libraries
nav_order: 3
description: "Official OPA libraries for Java, JavaScript, Python, PHP, and Ruby."
permalink: /libraries/
---

# Language Libraries
{: .fs-9 }

Official libraries for creating, signing, and verifying OPA files in your language of choice.
{: .fs-6 .fw-300 }

---

All libraries follow the OPA specification and support archive creation, digital signing, and signature verification. Each is open-source under the MIT license.

<img src="/opa-spec/assets/images/library-ecosystem.svg" alt="Library Ecosystem" style="width:100%; max-width:800px; margin:1rem auto; display:block;" />

## Java
{: .d-inline-block }

v0.1.0
{: .label .label-green }

A zero-dependency Java library for creating, reading, signing, and verifying OPA files. Requires Java 11+.

**Install with Maven:**

```xml
<dependency>
    <groupId>ca.weblite</groupId>
    <artifactId>opa-core</artifactId>
    <version>0.1.0-SNAPSHOT</version>
</dependency>
```

[View on GitHub](https://github.com/shannah/opa-java){: .btn .btn-primary .mr-2 }

---

## JavaScript
{: .d-inline-block }

npm
{: .label .label-green }

A minimal JavaScript library that works in both the browser and Node.js. Uses the Web Crypto API for secure browser-based signing.

**Install with npm:**

```bash
npm install opa-js
```

[View on GitHub](https://github.com/shannah/opa-js){: .btn .btn-primary .mr-2 }

---

## Python
{: .d-inline-block }

PyPI
{: .label .label-green }

A Python library with optional cryptographic signing support. No external dependencies for core functionality.

**Install with pip:**

```bash
pip install opa-archive
```

For signing support without requiring OpenSSL on your system path:

```bash
pip install opa-archive[crypto]
```

[View on GitHub](https://github.com/shannah/opa-python){: .btn .btn-primary .mr-2 }

---

## PHP
{: .d-inline-block }

Composer
{: .label .label-green }

A PHP library for generating, reading, signing, and verifying OPA files. Requires PHP 8.1+ with the `zip`, `json`, and `openssl` extensions.

**Install with Composer:**

```bash
composer require opa/opa-php
```

[View on GitHub](https://github.com/shannah/opa-php){: .btn .btn-primary .mr-2 }

---

## Ruby
{: .d-inline-block }

RubyGems
{: .label .label-green }

A zero-dependency Ruby library and CLI tool. Relies exclusively on Ruby's standard library (`zlib` and `openssl`).

**Install with gem:**

```bash
gem install opa-ruby
```

[View on GitHub](https://github.com/shannah/opa-ruby){: .btn .btn-primary .mr-2 }

---

## Feature Comparison

| Feature | Java | JavaScript | Python | PHP | Ruby |
|:--------|:----:|:----------:|:------:|:---:|:----:|
| Create archives | Yes | Yes | Yes | Yes | Yes |
| Read archives | Yes | Yes | Yes | Yes | Yes |
| Digital signing | Yes | Yes | Yes | Yes | Yes |
| Signature verification | Yes | Yes | Yes | Yes | Yes |
| CLI tool | Yes | -- | -- | -- | Yes |
| Zero dependencies | Yes | -- | Yes | -- | Yes |

---

{: .note }
> Don't see your language? The OPA format is built on ZIP and JSON — standard tools in every ecosystem. Check the [specification](/opa-spec/specification/) for everything you need to build your own implementation.
