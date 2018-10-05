:: "BUILD_SASS.bat" v1.0.0 (2018/09/30) by Tristano Ajmone
@ECHO OFF
ECHO.

SET "SRC=styles.scss"
SET "OUT=../styles.css"

ECHO =================================
ECHO Building CSS stylesheet
ECHO =================================
CALL SCSS %SRC% %OUT%
EXIT /B

