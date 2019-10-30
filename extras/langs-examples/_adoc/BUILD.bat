:: "BUILD.bat" v1.1.0 (2019/04/13) by Tristano Ajmone
:: -----------------------------------------------------------------------------
:: This script depends on the Highlight Treeprocessor Asciidoctor extension from
:: the "extras/AsciiDoc/" folder.
:: -----------------------------------------------------------------------------
@ECHO OFF
:: -----------------------------------------------------------------------------
:: Set HIGHLIGHT_DATADIR to the repository root to ensure that, when building
:: locally, Highlight will use the repository configurations scripts:
SET "HIGHLIGHT_DATADIR=%~dp0\..\..\..\"
:: The Highlight Treeprocessor extensions (>= v1.3.0) will enforce the path of
:: HIGHLIGHT_DATADIR via the --data-dir option.
:: -----------------------------------------------------------------------------
ECHO.
ECHO =====================================
ECHO Building "..\Highlight_Examples.html"
ECHO =====================================
CALL asciidoctor^
  --verbose^
  --safe-mode unsafe^
  --destination-dir ../^
  --template-dir haml^
  --require ../../AsciiDoc/highlight-treeprocessor_mod.rb^
  -a docinfo=private^
    Highlight_Examples.adoc
EXIT /B
