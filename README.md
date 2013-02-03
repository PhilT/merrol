Merrol - Minimalist Editor for Ruby, Rails and Other Languages


Things I want in an editor
===========================================================

* Fuzzy open
* Folder search / replace
* Syntax highlighting
* Switch between code/test quickly
* Split screen (vertical & horizontal)
* Small library of snippets
* Highlighting and snippets for Ruby, MiniTest::Spec, HAML, SASS, JavaScript, Markdown
* Trim trailing spaces
* Single empty last line
* Run commands or guard support
* Bracket matching
* Spell checker (for markdown)
* Remember open files and layout on exit


Sublime - Slow fuzzy open, slow code/test switcher, buggy snippets libraries, awkard plugin system, ensure_newline_at_eof_on_save should be run after trim trailing spaces,



Planned Features
===========================================================

* Designed with Test/Behaviour Driven Development in mind (VAGUE)
* Emphasis is on keyboard shortcuts over mouse, menus and toolbars
* Panels are used over dialogs so code is not obscured
* Switch between different layouts avoiding resizing of windows
* Split-screen showing test, code and output
* Simple configuration with YAML (shortcuts, settings, layouts, snippets)
* Folder and regex based search/replace panel
* Run tests on save and step through files/lines of failures/output
* Multiple instance support to work on different project folders
* Scratch files saved in projects tmp folder
* Written in pure Ruby in itself with BDD
* Console application runs on any *nix based OS


Status
===========================================================

Early development (Jan 2013)


Install
===========================================================

    gem install merrol


Usage
===========================================================

    m file1 file2 ...
    m file1:line


Motivation/Goals
===========================================================

* Take a fresh approach at a programmers editor
* Include everything I want to see in an editor
* Be oppinionated about the development process


Testing
===========================================================

* unit - Isolated tests stub all classes except the one under test
* functional - Test some of the interaction between objects
* integration - Full end-to-end testing with UI
