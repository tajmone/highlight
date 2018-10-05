:: "WATCH_SASS.bat" v1.0.0 (2018/09/30) by Tristano Ajmone
@ECHO OFF
ECHO.
CALL BUILD_SASS.bat
ECHO ======================================
ECHO Build ^& Watch Highlight.js' stylesheet
ECHO ======================================
ECHO DBG %SRC%:%DEST%
CALL SCSS --watch %SRC%:%OUT%
EXIT /B

