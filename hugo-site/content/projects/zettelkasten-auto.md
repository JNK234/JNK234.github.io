---
title: "Zettelkasten Automation"
description: "A local-first CLI that turns Obsidian source notes into atomic zettels, indexes them in ChromaDB, and builds context bundles"
summary: "CLI that extracts atomic notes from Obsidian sources with an LLM, dedupes them by title and embedding distance, and builds linked context bundles."
date: 2026-01-16
weight: 19
tags: ["Knowledge Management", "RAG", "ChromaDB", "LLM Apps", "Python"]
showTableOfContents: true
---

[Code on GitHub](https://github.com/JNK234/zettelkasten-auto)

## What it is

A command-line tool for an Obsidian vault. It reads long source notes (decoded papers, articles), pulls out the reusable ideas as atomic notes, links them, and keeps a local semantic index. It can then gather the notes around a source or a note into one bundle to hand to a model or read in one place.

It never deletes a source. A processed source gets a `Status: #processed` marker.

## How it works

`zettel process` handles each unprocessed source:

1. Skips notes that are already processed or too short.
2. Splits long sources by heading, then by paragraph.
3. Runs structured extraction per chunk and validates the output.
4. Drops candidate concepts that duplicate an existing note, by normalized title or by embedding distance.
5. Writes new notes from the vault template with `Tags`, `See Also` (semantic neighbours) and `References` (the source).
6. Indexes the notes in ChromaDB.

Each source ends with a named outcome, such as `processed`, `too_short`, `provider_error` or `invalid_output`.

`zettel bundle` collects the notes from a source or around one note, following tag links to a set depth. A dry run refuses to use a stale index rather than return wrong neighbours.

## Details

- LLM providers: OpenAI, Anthropic, Gemini and Ollama. Embeddings: OpenAI or a local sentence-transformer. The index is scoped to the embedding provider and model, so switching models does not mix vectors.
- `--dry-run` on every command that writes.
- The research-vault skills in [claude-kit](/projects/claude-kit/) use it for semantic search over zettels.
