# Highlight Examples Doc AsciiDoc Sources

This folder contains the sources for building the `Highlight_Examples.html` document.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Folder Contents](#folder-contents)
- [Credits](#credits)
    - [Highlight Extension](#highlight-extension)
    - [ERB Templates](#erb-templates)

<!-- /MarkdownTOC -->

-----


# Folder Contents

- [`/erb/`][erb] — customized ERB templates.
- [`BUILD.bat`][BUILD] — batch script to build document.
- [`Highlight_Examples.adoc`][adoc] — document source.
- [`Highlight_Examples-docinfo.html`][docinfo] — document docinfo file.
- [`highlight-treeprocessor_mod.rb`][rb] — extension for Highlight integration.

# Credits

## Highlight Extension

The [`highlight-treeprocessor_mod.rb`][rb] file was adapted by Tristano Ajmone from the original file [`highlight-treeprocessor.rb`][rb upstream] taken from the [Asciidoctor Extensions Lab] (commit 18bdf62), Copyright (C) 2014-2016
The Asciidoctor Project, released under MIT License:

    The MIT License

    Copyright (C) 2018 Tristano Ajmone.
    Copyright (C) 2014-2016 The Asciidoctor Project

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

## ERB Templates

The files inside the [`/erb/`][erb] folder were adapted by Tristano Ajmone from the original [ERB HTML5 templates] taken from the
[Asciidoctor Backends] project, Copyright (C) 2012-2016 Dan Allen and the Asciidoctor Project, released under MIT License:

    The MIT License
    
    Copyright (C) 2018 Tristano Ajmone.
    Copyright (C) 2012-2016 Dan Allen and the Asciidoctor Project

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.


<!-----------------------------------------------------------------------------
                               REFERENCE LINKS                                
------------------------------------------------------------------------------>

<!-- proj files -->

[erb]: ./erb
[BUILD]: ./adoc-build.bat
[adoc]: ./Highlight_Examples.adoc
[docinfo]: ./Highlight_Examples-docinfo.html
[rb]: ./highlight-treeprocessor_mod.rb

<!-- third party -->

[rb upstream]: https://github.com/asciidoctor/asciidoctor-extensions-lab/blob/18bdf62/lib/highlight-treeprocessor.rb
[Asciidoctor Extensions Lab]: https://github.com/asciidoctor/asciidoctor-extensions-lab/ "Visit the Asciidoctor Extensions Lab project"

[Asciidoctor Backends]: https://github.com/asciidoctor/asciidoctor-backends "Visit the Asciidoctor Backends project"
[ERB HTML5 templates]: https://github.com/asciidoctor/asciidoctor-backends/tree/master/erb/html5

<!-- EOF -->
