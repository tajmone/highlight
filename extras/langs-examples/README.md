# Syntax Highlighting Examples

A collection of syntax highlighting examples for Highlight's natively supported languages.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Folder Contents](#folder-contents)
- [About the Examples](#about-the-examples)
    - [Examples Source Files](#examples-source-files)
    - [Examples Preview Document](#examples-preview-document)
    - [Current Status](#current-status)

<!-- /MarkdownTOC -->

-----

# Folder Contents

End user contents:

- [`/ex-src/`][ex-src] — examples source files.
- [`Highlight_Examples.html`][ex html] — example preview document.
- [`styles.css`][css] — stylesheets for preview document.

Extra files and source material for maintainers:

- [`/_adoc/`][_adoc] — AsciiDoc sources to build preview document.
- [`/_sass/`][_sass] — Sass sources to build .
- [`CONTRIBUTING.md `][contribute] — contributors guidelines.


# About the Examples

The goal of this folder is to gather a source code example for every language natively supported by Highlight.

## Examples Source Files

The examples source files are stored in the [`ex-src/`][ex-src] folder, so they can be easily accessed via Highlight GUI for testing themes:

- [`/ex-src/`][ex-src]

Beside offering a quick preview of how a language can be colorized by Highlight, examples files should also serve the following purposes:

- __Theme Design__ — Theme designers need test how a theme looks across various languages.
- __Theme Picking__ — A web designer might need to choose a theme that looks nice with a particular language. 

## Examples Preview Document

A single HTML document containing all the highlighted examples and some extra info on the languages is also available:

- [`Highlight_Examples.html`][ex html]

## Current Status

This sub-project is in its early stage, so only a few languages have an example at this moment. The ultimate goal is to provide an example for every supported language, so if you are fluent in any of the missing languages feel free to [contribute] your own example files.

| highlight | languages | examples |
|-----------|-----------|----------|
| v3.45     |       224 |        1 |



<!-----------------------------------------------------------------------------
                               REFERENCE LINKS                                
------------------------------------------------------------------------------>


[contribute]: ./CONTRIBUTING.md "Read the Contributors guidelines document"

[ex-src]: ./ex-src "View the examples sources folder"

[ex html]: ./Highlight_Examples.html "View the examples document"

[_adoc]: ./_adoc
[_sass]: ./_sass
[css]: ./styles.css

<!-- EOF -->
