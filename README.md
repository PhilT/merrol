Merrol - Minimalist Editor for Ruby, Rails and Other Languages

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
* Uses GTK and the Ruby Gnome2 project


Status
===========================================================

Early development (November 2011) - few features are implemented


Install
===========================================================

Initially targeting Ubuntu.

    sudo apt-get -y install libgtk2.0-dev libgtksourceview2.0-dev
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
* Only integration tests should display a GTK window


Design & Development
===========================================================

* The gooy folder contains facades around GTK (to facilate upgrade to GTK+ 3)
  It should not contain business logic or any references to the application


Testing
===========================================================

* unit - Stub all classes except the one under test
* functional - Test some of the interaction between objects
* integration - Full end-to-end testing with UI

