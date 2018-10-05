
=begin    highlight-treeprocessor_mod.rb"                    v1.0.0 (2018-10-04)
================================================================================

                        Highlight Treprocessor Extension

================================================================================
A treeprocessor that highlights source cdoe blocks using Highlight.

Usage:

  :source-highlighter: highlight

  [source,ruby]
  ----
  puts 'Hello, World!'
  ----

--------------------------------------------------------------------------------
Adapted by Tristano Ajmone from the original "highlight-treeprocessor.rb" taken
from the Asciidoctor Extensions Lab (commit 18bdf62), Copyright (C) 2014-2016
The Asciidoctor Project, released under MIT License:

    https://github.com/asciidoctor/asciidoctor-extensions-lab/
--------------------------------------------------------------------------------
The extension was modified (trimmed down) in order to:
- enforce ':highlight-css: class' without requiring attribute settingss.
- disable the ':highlight-style:' option (we use custom CSS in this context).
--------------------------------------------------------------------------------
=end

require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'
require 'open3'

include Asciidoctor


Extensions.register do
  # =============
  # TreeProcessor 
  # =============
  # Processes the Asciidoctor::Document (AST) once parsing is complete.
  # ----------------------------------------------------------------------------
  treeprocessor do
    process do |document|
      document.find_by context: :listing, style: 'source' do |src|
        # TODO handle callout numbers
        src.subs.clear
        lang = src.attr 'language', 'text', false
        highlight = document.attr 'highlight', 'highlight'
        # highlight = document.attr 'highlight', 'highlight'
        cmd = %(#{highlight} -f -O html --src-lang #{lang})
        cmd = %(#{cmd} -l -j 2) if src.attr? 'linenums', nil, false
        Open3.popen3 cmd do |stdin, stdout, stderr, wait_thr|
          stdin.write src.source
          stdin.close
          result = []
          while (line = stdout.gets)
            result << line.chomp
          end
          src.lines.replace result
          wait_thr.value
        end
      end if document.attr? 'source-highlighter', 'highlight'
      nil
    end 
  end
end
