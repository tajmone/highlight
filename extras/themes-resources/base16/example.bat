:: =============================================================================
::                  Test Base16 to Highlight Theme Conversion
:: =============================================================================
:: This script requires the following Node.js apps to be installed globally:
:: - mustache.js
::   https://www.npmjs.com/package/mustache
:: - yaml-utils
::   https://www.npmjs.com/package/yaml-utils
:: -----------------------------------------------------------------------------

:: Convert Base16 scheme to Highlight Theme:
yaml2json < example.yaml ^
          | mustache - base16_highlight.mustache ^
          > example.theme

:: Convert Base16 scheme to Light Highlight Theme:
yaml2json < example.yaml ^
          | mustache - base16_highlight_light.mustache ^
          > example_light.theme

:: Test Dark Theme with some code:
highlight ^
    --config-file=example.theme ^
    --include-style ^
    --validate-input ^
    --doc-title="Base16 Eighties (Dark)" ^
    --font-size=16 ^
    --line-numbers ^
    -o  example-dark.html ^
        example.pb

:: Test Light Theme with some code:
highlight ^
    --config-file=example_light.theme ^
    --include-style ^
    --validate-input ^
    --doc-title="Base16 Eighties (Light)" ^
    --font-size=16 ^
    --line-numbers ^
    -o  example-light.html ^
        example.pb

EXIT /B
