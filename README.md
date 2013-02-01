Merrol - Minimalist Editor for Ruby, Rails and Other Languages


Planned Features
===========================================================

* Designed with Test/Behaviour Driven Development in mind
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
