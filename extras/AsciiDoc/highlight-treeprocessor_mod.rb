=begin

highlight-treeprocessor_mod.rb"         v1.3.0 | 2019/03/30 | by Tristano Ajmone
================================================================================

                        Highlight Treeprocessor Extension

================================================================================
A treeprocessor that highlights source code using André Simon's Highlight:

  http://www.andre-simon.de

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
- enforce `:highlight-css: class` without requiring attribute settings.
- disable the `:highlight-style:` option (we use custom CSS in this context).
- enable substitutions
- correctly handle the `linenums` option.
- Enforce $HIGHLIGHT_DATADIR via "--data-dir=" option (if defined).
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

        #-----------------------------------------------------------------------
        # ** SUBSTITUTIONS ** were enabled by commenting out the following line:
        # ~~~~~~~~~~~~~~
        # src.subs.clear
        # ~~~~~~~~~~~~~~
        # If no `subs` are specified in the listing block, the default setting
        # will be to substitute special characters, which breaks up the code.
        # Therefore, we check if the `subs` array contains `:specialcharacters`
        # and eliminate it if it does:
        spchindx = src.subs.index(:specialcharacters)
        src.subs.delete_at(spchindx) if spchindx
        #-----------------------------------------------------------------------
        # ** ENFORCE HIGHLIGHT DATADIR **
        #
        # If the HIGHLIGHT_DATADIR env var is defined we'll enforce it via
        # Highlight option "--data-dir=<HIGHLIGHT_DATADIR>" so that it gets the
        # highest override priority:

        if ENV['HIGHLIGHT_DATADIR'] != nil
          hlDataDir=" --data-dir=" + ENV['HIGHLIGHT_DATADIR']
        else
          hlDataDir=""
        end

        # This ensures that custom langDefs will always override the predefined
        # ones, whereas usually the the path of the HIGHLIGHT_DATADIR env var
        # would be searched after Highlight installation folder.
        #-----------------------------------------------------------------------

        lang = src.attr 'language', 'text', false
        highlight = document.attr 'highlight', 'highlight'
        cmd = %(#{highlight} -f -O html --src-lang #{lang} #{hlDataDir})
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

=begin
--------------------------------------------------------------------------------
                                   ChangeLog
--------------------------------------------------------------------------------
v1.3.0 (2019/03/30)
  Enforce $HIGHLIGHT_DATADIR:
  - If the HIGHLIGHT_DATADIR env var is defined then enforce it via:

        --data-dir=<HIGHLIGHT_DATADIR>

    This ensures that custom langDefs will always override same-named files in
    Highlight installation folder.

v1.2.0 (2019/03/24)
  Fixes the problems introduced in v1.1.0:
  - Added code to handle defaults in listing with unspecified `subs`.
  - No longer mandatory to specify `subs` in listing block.
  - Option `linenums` works correctly again.

v1.1.0 (2019/03/13)
  - Enabled substitutions, but the `linenums` option doesn't work anymore.
  - Requires mandatory declaration of `subs` in code listings (even if only
    `subs=none`) otherwise the sourcedcode breaks up in the listing block.

v1.0.0 (2018/10/04)
  First mod, based commit 18bdf62:
  - Enforce `:highlight-css: class` without requiring attribute settings.
  - Disable the `:highlight-style:` option (we use custom CSS in this context).

=end