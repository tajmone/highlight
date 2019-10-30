#!/bin/bash
# ------------------------------------------------------------------------------
# "build.sh"                            v1.0.0 | 2019/03/25 | by Tristano Ajmone
# ------------------------------------------------------------------------------
# This script requires Dart Sass to be installed on the system:
#      https://github.com/sass/dart-sass
#
# Under Windows you can use Chocolatey to install Dart Sass and keep it updated:
#      https://chocolatey.org/packages/sass
# ------------------------------------------------------------------------------
echo -e "Compiling the CSS stylesheet"
sass \
	./highlight_mod.scss \
	../highlight_mod.css
echo -e "/// Finished ///"
exit
