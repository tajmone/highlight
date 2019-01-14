#!/bin/bash

# "highlight-langs2adoc.sh" v1.0.0 | 2019/01/13 | by Tristano Ajmone | MIT License
# ******************************************************************************
# *                                                                            *
# *                    Highlight Languages 2 AsciiDoc Page                     *
# *                                                                            *
# ******************************************************************************
# The script queries Highlight for its version and the full list of packaged
# languages, it then creates a well formatted AsciiDoc file.
# 
# Created for autoupdating the Highlight README_LANGLIST page that lists all the
# supported languages by the latest Highlight version:
# 
#   https://gitlab.com/saalen/highlight/README_LANGLIST.adoc
# 
# You're free to adapt this script to your own needs, but please do honour its
# license terms and duely credit me!
# ------------------------------------------------------------------------------
echo "==========================================="
echo "Autogenerating Highlight langs list page..."
echo "==========================================="

# ===========================
# Setup Environment Variables
# ===========================
# The output AsciiDoc file:
OUT_FILE="./README_LANGLIST.adoc"

# =========================
# Retrive Highlight Version
# =========================
HL_VER="$(highlight --version | grep -P -o -m1 '\d\.\d\d')"
echo "Highlight version found: ${HL_VER}"

# ================================
# Retrive Current Date (Moth Year)
# ================================
CURR_DATE="$(LANG=en_US.utf8 date -u '+%B %Y')"
echo "Current date: ${CURR_DATE}"

# =================================
# Write Document Chunk #1 -- Header
# =================================
cat << EOF > $OUT_FILE
= HIGHLIGHT LANGUAGES LIST
André Simon
v${HL_VER}, ${CURR_DATE}
:lang: en
:experimental:
:icons: font
:linkattrs:
:toc!:
// GitHub Settings for Admonitions Icons:
ifdef::env-github[]
:caution-caption: :fire:
:important-caption: :heavy_exclamation_mark:
:note-caption: :information_source:
:tip-caption: :bulb:
:warning-caption: :warning:
endif::[]

////
***************************************** 
* THIS IS AN AUTO-GENERATED DOCUMENT!!! *
***************************************** 
Any manual changes to this document will be
overwritten by automated scripted updates!
////

// =====================================
// Custom Attributes for Reference Links
// =====================================
:README: pass:q[link:README.adoc[\`README\`]]
:filetypes_conf: pass:q[link:filetypes.conf[\`filetypes.conf\`^]]
:script: pass:q[link:highlight-langs2md.sh[script^,title="View source of 'highlight-langs2md.sh' script"]]

The table below lists all supported languages, their syntax definition filenames,
and the associated file extensions (configured in {filetypes_conf}).

By default, the \`*.lang\` files are located in \`/usr/share/highlight/langDefs/\`.
See the {README} for other user defined locations.

# Languages List

Packaged language definitions, obtained via \`highlight --list-langs\`

[cols="<4d,<1m,<5m"]
|==========================================
| Language | Filename | Extensions

EOF
# =====================================
# Write Document Chunk #2 -- Langs List
# =====================================
highlight --list-langs |\
    grep -x -E '^(.*?)( *: )(.*?)$' |\
    sed -E 's/^(.*?): *(\w+)(( +\()(.*?)( +\)))?/| \1 | link:.\/langDefs\/\2.lang[`\2.lang`,title="View source file"] | \5/g' |\
    sort -\
    >> $OUT_FILE
# =================================
# Write Document Chunk #3 -- Footer
# =================================
cat << EOF >> $OUT_FILE
|==========================================

[NOTE]
This page is autogenerated via a {script}.
Any manual edits to the page will be lost when the page is updated.


EOF

# ------------------------------------------------------------------------------
# MIT License
# 
# Copyright (c) 2018 Tristano Ajmone <tajmone@gmail.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# ------------------------------------------------------------------------------
