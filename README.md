Merrol
======
Minimalist Editor for Ruby, Rails and Other Languages


Status
----------------------------------
**Under development (October 2010)**

**The first release is out (0.0.2)!** It has syntax highlighting, loads mulitple files (from command line), save (CTRL+S) and switch files (CTRL+TAB). It should be stable but there isn't much to it yet.

Next up is Open (CTRL+O). Quite a few commands rely on this panel so this should enable other things to follow quickly.


What
----------------------------------
An editor for Ruby, Rails and supporting langauges, written in pure Ruby (1.9) and GTK using some Rails idioms with an open design to allow customization and enhancement.


Why
----------------------------------
I noticed, while using other editors that I found myself constantly re-arranging windows to get the optimum setup. I was also frustrated by little bugs, design issues and sensible shortcuts. I thought, there must be a better way.

I want to make an editor that is really easy to tweak. Users would be able to fork it and customize it as they saw fit. It will also make use of existing apps such as autotest and rails generators and commands such as grep.

I want to try something different. To create an editor that is focused on BDD and TDD from the ground up.


Goals
----------------------------------
To get the most out of a screen whether it's a 30" desktop or a 13" laptop. Control screens without having to resize windows. Maximize the workspace.

Foremost, it will be a Rails and Ruby editor with an emphasis on Behaviour and Test Driven Development. There will be nothing stopping it being customized for other languages and there will be nothing to stop it being forked or plugins added, although a plugin system is not currently planned.

No toolbars, menus, icons or any other extra fluff. Straightforward shortcuts will allow access to all functions.

It will be robust, built with well factored, well tested, pure Ruby code

There will be no dialogs. Panels will allow a more versatile and accessible way to accept input.

Support multiple instances for loading different application directories.

It will be developed primarily for the Linux OS in particular it uses ruby GNOME 2. However, this is a cross platform library so it should work on Windows and Mac OS.


!What
----------------------------------
It will not be a full blown IDE. There are plenty of these about and I don't believe they are necessary for Ruby or Rails development.

It will not support TextMate bundles.


Features
----------------------------------
* Configuration is all done in YAML files. Configure anything then CTRL+Y to reload all YAML files. Change shortcuts, settings, themes, views, snippets, etc.
* Panels - replace the outdated dialog box. Continue working even with it open.
* Fuzzy File Panel - Open, create and rename files quickly and easily by pattern matching and selection. Starts with a folder view to aid navigation. Supports exclusions via .gitignore and globs (configurable, obviously)
* Written with pure Ruby version 1.9.2 and Ruby-GNOME2
* Fast startup time

