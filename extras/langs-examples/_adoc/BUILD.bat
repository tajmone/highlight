:: "BUILD.bat" v1.0.0 (2018/10/05) by Tristano Ajmone
@ECHO OFF
ECHO.

ECHO =====================================
ECHO Building "..\Highlight_Examples.html"
ECHO =====================================
CALL asciidoctor^
	--verbose^
	--safe-mode unsafe^
	--destination-dir ../^
	--template-dir erb^
	--require ./highlight-treeprocessor_mod.rb^
	 -a docinfo=private^
	   Highlight_Examples.adoc
EXIT /B
