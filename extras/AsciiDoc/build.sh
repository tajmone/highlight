#!/bin/bash

# Convert using the original HighlightTreeprocessor extension:
asciidoctor \
	-r ./highlight-treeprocessor.rb \
	-a source-highlighter=highlight \
	example.asciidoc

# Convert using the modded HighlightTreeprocessor extension:
asciidoctor \
	-r ./highlight-treeprocessor_mod.rb \
	-a source-highlighter=highlight \
	-a docinfo=shared \
	-T haml \
	README.asciidoc

asciidoctor \
	-r ./highlight-treeprocessor_mod.rb \
	-a source-highlighter=highlight \
	-a docinfo=shared \
	-T haml \
	example_mod.asciidoc
